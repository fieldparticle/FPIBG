/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************GPO
% $Author: jb $
%
% $Date: 2023-06-12 16:17:58 -0400 (Mon, 12 Jun 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src_app/mfpm/DrawObj.cpp $
% $Id: DrawObj.cpp 31 2023-06-12 20:17:58Z jb $
%*******************************************************************
%***                         DESCRIPTION                         ***
%*******************************************************************
@doc
@module
			@author: Jackie Michael Bell<nl>
			COPYRIGHT <cp> Jackie Michael Bell<nl>
			Property of Jackie Michael Bell<rtm>. All Rights Reserved.<nl>
			This source code file contains proprietary<nl>
			and confidential information.<nl>


@head3 		Description. |
@normal


********************************************************************
%***                     SVN CHANGE RECORD                       ***
%*******************************************************************
%*$Revision: 31 $
%*
%*
%******************************************************************/
#include "VulkanObj/VulkanApp.hpp"
///FIXX THIS
void DrawParticleHeadless::Create(CommandPoolObj* CPL,
	SwapChainObj* SCO,
	RenderPassObj* RPO,
	FrameBufferObj* FBO,
	SyncObj* SO)
{
	m_CPL = CPL;
	m_SCO = SCO;
	m_FBO = FBO; 
	m_SO = SO;
	m_ComputeCommandObj = m_CPL->GetCommandObjByName("CommandParticleCompute");
	m_GraphicsCommandObj = m_CPL->GetCommandObjByName("CommandObjParticleGraphics");
	m_Graphicslst = m_GraphicsCommandObj->m_RCO->m_DRList;
	m_Computelst = m_ComputeCommandObj->m_RCO->m_DRList;
	
}

void DrawParticleHeadless::DrawFrame()
{
	VkResult ret;
	
	//=========================================================
	// Allocate all semaphores
	//=========================================================
	
	
	
	//=========================================================
	// Wait for compute fences
	//=========================================================
	if ((ret = vkWaitForFences(m_App->GetLogicalDevice(), 1,
		&m_SO->m_Fences[SyncObjPO::F_CINFLIGHT].fencevec[currentBuffer], VK_TRUE, UINT64_MAX)) != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkWaitForFences failed:" << ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};
	if(Extflg == true)
		return ;
	//=========================================================
	// Update Compute resources
	//=========================================================

	m_Computelst[0]->PushMem(currentBuffer);
	m_Computelst[3]->PushMem(currentBuffer);

	ret = vkResetFences(m_App->GetLogicalDevice(), 1,
		&m_SO->m_Fences[SyncObjPO::F_CINFLIGHT].fencevec[currentBuffer]);
	if (ret != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkResetFences computeInFlightFences failed:" << ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};
	if(Extflg == true)
		return ;


	//=========================================================
	// Reset Compute Command Buffers.
	//=========================================================

	ret = vkResetCommandBuffer(
		m_ComputeCommandObj->m_CommandBuffers[currentBuffer],
		VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT);
	if (ret != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkResetCommandBuffer failed:"
			<< ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};

		

	//=========================================================
	// Record Compute commands
	//=========================================================
	m_ComputeCommandObj->RecordCommands(0,currentBuffer);
	if(Extflg == true)
		return ;
	VkSubmitInfo csubmitInfo{};
	csubmitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
	csubmitInfo.commandBufferCount = 1;
	csubmitInfo.pCommandBuffers =
		&m_ComputeCommandObj->m_CommandBuffers[currentBuffer];
	csubmitInfo.signalSemaphoreCount = 1;
	csubmitInfo.pSignalSemaphores =
		&m_SO->m_WaitSemaphores[SyncObjPO::W_COMPUTEFIN].semvec[currentBuffer];
	if(Extflg == true)
		return ;

	//=========================================================
	// Submit Compute commands
	//=========================================================
	ret = vkQueueSubmit(m_App->GetComputeQueue(), 1, &csubmitInfo,
		m_SO->m_Fences[SyncObjPO::F_CINFLIGHT].fencevec[currentBuffer]);
	if (ret != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkQueueSubmit GetComputeQueue failed:"
			<< ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};
	m_ComputeCommandObj->FetchRenderTimeResults(currentBuffer);
#ifndef NDEBUG
	m_Computelst[3]->PullMem(currentBuffer);
#endif
	if(Extflg == true)
		return ;
	//########################################### Graphics ##########################################################
	//=========================================================
	// Wait for graphics fences
	//=========================================================

#if 1
	ret = vkWaitForFences(m_App->GetLogicalDevice(), 1,
		&m_SO->m_Fences[SyncObjPO::F_INFLIGHT].fencevec[currentBuffer], VK_TRUE, UINT64_MAX);
	if (ret != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkWaitForFences inFlightFences failed:" << ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};
#endif
	// Get draw count from compute


	//=========================================================
	// Acquire next completed image from swap-chain. Get the id of swap chain image
// 
	//=========================================================
	uint32_t imageIndex = 0;
	VkResult result = vkAcquireNextImageKHR(
		m_App->GetLogicalDevice(),
		m_SCO->m_SwapChain,
		UINT64_MAX,
		m_SO->m_WaitSemaphores[SyncObjPO::W_IMAGAVAIL].semvec[currentBuffer],
		VK_NULL_HANDLE,
		&imageIndex);
	if (result == VK_ERROR_OUT_OF_DATE_KHR)
	{
		//m_SCO->RecreateSwapChain(m_FBO);
		return;
	}
	else if (result != VK_SUCCESS && result != VK_SUBOPTIMAL_KHR)
	{
		throw std::runtime_error("Acquire Swap Chain Image Error.");
	}


	//=========================================================
	// Reset all fences unsignald
	//=========================================================
	ret = vkResetFences(m_App->GetLogicalDevice(), 1, &m_SO->m_Fences[SyncObjPO::F_INFLIGHT].fencevec[currentBuffer]);
	if (ret != VK_SUCCESS)
	{

		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkResetFences inFlightFences failed:" << ret << std::ends;

		throw std::runtime_error(objtxt.str().c_str());
	};

	//=========================================================
	// 	// Clear command buffer to rerecord. 
	//  If everything is on the GPU chnage this.
	//=========================================================
	ret = vkResetCommandBuffer(m_GraphicsCommandObj->m_CommandBuffers[currentBuffer],
		VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT);
	if (ret != VK_SUCCESS)
	{
		std::ostringstream  objtxt;
		objtxt << "DrawIParticle::DrawFrame() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
		throw std::runtime_error(objtxt.str().c_str());
	};
	
	m_Graphicslst[1]->PushMem(currentBuffer);
	m_Graphicslst[2]->PushMem(currentBuffer);
	m_Graphicslst[5]->PushMem(currentBuffer);

	// Record a new command buffer for the current frame and associate with swap chain image.
	m_GraphicsCommandObj->RecordCommands(imageIndex,currentBuffer );
	if(Extflg == true)
		return ;
	VkSemaphore waitSemaphores[] = 
	{ m_SO->m_WaitSemaphores[SyncObjPO::W_COMPUTEFIN].semvec[currentBuffer] ,
			m_SO->m_WaitSemaphores[SyncObjPO::W_IMAGAVAIL].semvec[currentBuffer] };
	if(Extflg == true)
		return ;
	VkPipelineStageFlags waitStages[] = 
	{ m_SO->m_WaitSemaphores[SyncObjPO::W_COMPUTEFIN].pipeStage[currentBuffer] ,
			m_SO->m_WaitSemaphores[SyncObjPO::W_IMAGAVAIL].pipeStage[currentBuffer] };
	if(Extflg == true)
		return ;
	// Build submit info
	VkSubmitInfo submitInfo = {};
	submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
	submitInfo.waitSemaphoreCount = 2;
	submitInfo.pWaitSemaphores = waitSemaphores,
	submitInfo.pWaitDstStageMask = waitStages,
	submitInfo.commandBufferCount = 1;
	submitInfo.pCommandBuffers = &m_GraphicsCommandObj->m_CommandBuffers[currentBuffer];
	submitInfo.signalSemaphoreCount = 1;
	submitInfo.pSignalSemaphores = &m_SO->m_SigSemaphores[SyncObjPO::S_RENDERFIN].semvec[currentBuffer];
	if(Extflg == true)
		return ;

	// Submit the command pool to the graphics command queue.
	VkResult subret = vkQueueSubmit(m_App->GetGraphicsQueue(),
		1,
		&submitInfo,
		m_SO->m_Fences[SyncObjPO::F_INFLIGHT].fencevec[currentBuffer]);
	std::ostringstream  objtxt;
	if (subret == VK_ERROR_OUT_OF_HOST_MEMORY)
	{
		objtxt << "Error - DrawObj:" << m_Name
			<< " Returns:VK_ERROR_OUT_OF_HOST_MEMORY " << m_App->m_TotalMemoryBytes << std::ends;
		throw std::runtime_error(objtxt.str());
	}
	else
		if (subret == VK_ERROR_OUT_OF_DEVICE_MEMORY)
		{
			objtxt << "Error - DrawObj:" << m_Name
				<< " Returns:VK_ERROR_OUT_OF_DEVICE_MEMORY " << m_App->m_TotalMemoryBytes << std::ends;
			throw std::runtime_error(objtxt.str());
		}
		else
			if (subret == VK_ERROR_DEVICE_LOST)
			{
				objtxt << "Error - DrawObj:" << m_Name
					<< " Returns:VK_ERROR_DEVICE_LOST" << m_App->m_TotalMemoryBytes << std::ends;
				throw std::runtime_error(objtxt.str());

			}
	m_GraphicsCommandObj->FetchRenderTimeResults(currentBuffer);
#ifndef NDEBUG
	m_Graphicslst[5]->PullMem(currentBuffer);
#endif
	// Wait for complettion of rendering then pick up the completed frame buffer 
	// and send to presentation device.
	VkSwapchainKHR swapChains[] = { m_SCO->m_SwapChain };

	// Build presentation info
	VkPresentInfoKHR presentInfo{};
	presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
	presentInfo.waitSemaphoreCount = 1;
	presentInfo.pWaitSemaphores = &m_SO->m_SigSemaphores[SyncObjPO::S_RENDERFIN].semvec[currentBuffer];
	presentInfo.swapchainCount = 1;
	presentInfo.pSwapchains = swapChains;
	presentInfo.pImageIndices = &imageIndex;

	// Send to presentation device
	result = vkQueuePresentKHR(m_App->GetPresentQueue(), &presentInfo);
	if (result == VK_ERROR_OUT_OF_DATE_KHR ||
		result == VK_SUBOPTIMAL_KHR)
	{
		//	m_App->m_FramebufferResized = false;
		//	m_SCO->RecreateSwapChain(m_FBO);
	}
	else if (result != VK_SUCCESS)
	{
		throw std::runtime_error("vkQueuePresentKHR in DrawFrame Failed.");
	}
	SaveImage();
	currentBuffer = (currentBuffer + 1) % m_App->m_FramesBuffered;
	m_App->SetCurrentBuffer(currentBuffer);
		
	

}

void DrawParticleHeadless::SaveImage()
{


	const char* imagedata;
		{
			// Create the linear tiled destination image to copy to and to read the memory from
			VkImageCreateInfo imgCreateInfo;
			imgCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
			imgCreateInfo.imageType = VK_IMAGE_TYPE_2D;
			imgCreateInfo.format = VK_FORMAT_R8G8B8A8_UNORM;
			imgCreateInfo.extent.width = m_SCO->GetSwapWidth();
			imgCreateInfo.extent.height = m_SCO->GetSwapHeight();
			imgCreateInfo.extent.depth = 1;
			imgCreateInfo.arrayLayers = 1;
			imgCreateInfo.mipLevels = 1;
			imgCreateInfo.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
			imgCreateInfo.samples = VK_SAMPLE_COUNT_1_BIT;
			imgCreateInfo.tiling = VK_IMAGE_TILING_LINEAR;
			imgCreateInfo.usage = VK_IMAGE_USAGE_TRANSFER_DST_BIT;
			// Create the image
			VkImage dstImage;
			uint32_t ret = vkCreateImage(m_App->GetLogicalDevice(), &imgCreateInfo, nullptr, &dstImage);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::DrawFrame() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			// Create memory to back up the image
			VkMemoryRequirements memRequirements;
			VkMemoryAllocateInfo memAllocInfo(vks::initializers::memoryAllocateInfo());
			VkDeviceMemory dstImageMemory;

			vkGetImageMemoryRequirements(m_App->GetLogicalDevice(), dstImage, &memRequirements);
			memAllocInfo.allocationSize = memRequirements.size;

			// Memory must be host visible to copy from
			memAllocInfo.memoryTypeIndex = getMemoryTypeIndex(memRequirements.memoryTypeBits, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);

			ret = vkAllocateMemory(m_App->GetLogicalDevice(), &memAllocInfo, nullptr, &dstImageMemory);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			vkBindImageMemory(m_App->GetLogicalDevice(), dstImage, dstImageMemory, 0);


			// Do the actual blit from the offscreen image to our host visible destination image

			VkCommandBufferAllocateInfo cmdBufAllocateInfo = vks::initializers::commandBufferAllocateInfo(commandPool, VK_COMMAND_BUFFER_LEVEL_PRIMARY, 1);
			VkCommandBuffer copyCmd;
			ret = vkAllocateCommandBuffers(m_App->GetLogicalDevice(), &cmdBufAllocateInfo, &copyCmd);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			VkCommandBufferBeginInfo cmdBufInfo;
			cmdBufInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
			ret = vkBeginCommandBuffer(copyCmd, &cmdBufInfo);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			// Transition destination image to transfer destination layout
			vks::tools::insertImageMemoryBarrier(
				copyCmd,
				dstImage,
				0,
				VK_ACCESS_TRANSFER_WRITE_BIT,
				VK_IMAGE_LAYOUT_UNDEFINED,
				VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
				VK_PIPELINE_STAGE_TRANSFER_BIT,
				VK_PIPELINE_STAGE_TRANSFER_BIT,
				VkImageSubresourceRange{ VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1 });

			// colorAttachment.image is already in VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL, and does not need to be transitioned

			VkImageCopy imageCopyRegion{};
			imageCopyRegion.srcSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
			imageCopyRegion.srcSubresource.layerCount = 1;
			imageCopyRegion.dstSubresource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
			imageCopyRegion.dstSubresource.layerCount = 1;
			imageCopyRegion.extent.width = m_SCO->GetSwapWidth();;
			imageCopyRegion.extent.height = m_SCO->GetSwapHeight();
			imageCopyRegion.extent.depth = 1;

			vkCmdCopyImage(
				copyCmd,
				colorAttachment.image, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL,
				dstImage, VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
				1,
				&imageCopyRegion);

			// Transition destination image to general layout, which is the required layout for mapping the image memory later on
			vks::tools::insertImageMemoryBarrier(
				copyCmd,
				dstImage,
				VK_ACCESS_TRANSFER_WRITE_BIT,
				VK_ACCESS_MEMORY_READ_BIT,
				VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL,
				VK_IMAGE_LAYOUT_GENERAL,
				VK_PIPELINE_STAGE_TRANSFER_BIT,
				VK_PIPELINE_STAGE_TRANSFER_BIT,
				VkImageSubresourceRange{ VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1 });

			ret = vkEndCommandBuffer(copyCmd);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};

			VkSubmitInfo submitInfo;
			submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
			submitInfo.commandBufferCount = 1;
			submitInfo.pCommandBuffers = &m_GraphicsCommandObj->m_CommandBuffers[currentBuffer];;

			VkFenceCreateInfo fenceInfo;
			fenceInfo.sType = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
			fenceInfo.flags = 0;

			VkFence fence;
			ret =vkCreateFence(m_App->GetLogicalDevice(), &fenceInfo, nullptr, &fence);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			ret = vkQueueSubmit(m_App->GetGraphicsQueue(), 1, &submitInfo, fence);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			ret = vkWaitForFences(m_App->GetLogicalDevice(), 1, &fence, VK_TRUE, UINT64_MAX);
			if (ret != VK_SUCCESS)
			{
				std::ostringstream  objtxt;
				objtxt << "DrawIParticle::vkAllocateMemory() vkResetCommandBuffer m_CommandGBuffers failed:" << ret << std::ends;
				throw std::runtime_error(objtxt.str().c_str());
			};
			vkDestroyFence(m_App->GetLogicalDevice(), fence, nullptr);

			// Get layout of the image (including row pitch)
			VkImageSubresource subResource{};
			subResource.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
			VkSubresourceLayout subResourceLayout;

			vkGetImageSubresourceLayout(m_App->GetLogicalDevice(), dstImage, &subResource, &subResourceLayout);

			// Map image memory so we can start copying from it
			vkMapMemory(m_App->GetLogicalDevice(), dstImageMemory, 0, VK_WHOLE_SIZE, 0, (void**)&imagedata);
			imagedata += subResourceLayout.offset;

		/*
			Save host visible framebuffer image to disk (ppm format)
		*/


			const char* filename = "headless.ppm";
			std::ofstream file(filename, std::ios::out | std::ios::binary);

			// ppm header
			file << "P6\n" << m_SCO->GetSwapWidth() << "\n" << m_SCO->GetSwapHeight() << "\n" << 255 << "\n";

			// If source is BGR (destination is always RGB) and we can't use blit (which does automatic conversion), we'll have to manually swizzle color components
			// Check if source is BGR and needs swizzle
			std::vector<VkFormat> formatsBGR = { VK_FORMAT_B8G8R8A8_SRGB, VK_FORMAT_B8G8R8A8_UNORM, VK_FORMAT_B8G8R8A8_SNORM };
			const bool colorSwizzle = (std::find(formatsBGR.begin(), formatsBGR.end(), VK_FORMAT_R8G8B8A8_UNORM) != formatsBGR.end());

			// ppm binary pixel data
			for (int32_t y = 0; y < m_SCO->GetSwapHeight(); y++) {
				unsigned int *row = (unsigned int*)imagedata;
				for (int32_t x = 0; x < m_SCO->GetSwapWidth() x++) {
					if (colorSwizzle) {
						file.write((char*)row + 2, 1);
						file.write((char*)row + 1, 1);
						file.write((char*)row, 1);
					}
					else {
						file.write((char*)row, 3);
					}
					row++;
				}
				imagedata += subResourceLayout.rowPitch;
			}
			file.close();

			

			// Clean up resources
			vkUnmapMemory(m_App->GetLogicalDevice(), dstImageMemory);
			vkFreeMemory(m_App->GetLogicalDevice(), dstImageMemory, nullptr);
			vkDestroyImage(m_App->GetLogicalDevice(), dstImage, nullptr);
		}

		
	}
