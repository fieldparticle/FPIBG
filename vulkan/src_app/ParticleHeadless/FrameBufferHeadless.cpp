/*******************************************************************
%***      C PROPRIETARY SOURCE FILE IDENTIFICATION               ***
%*******************************************************************
% $Author: jb $
%
% $Date: 2023-06-12 16:17:58 -0400 (Mon, 12 Jun 2023) $
% $HeadURL: https://jbworkstation/svn/svnrootr5/svnvulcan/src_app/mfpm/FrameBuffer.cpp $
% $Id: FrameBuffer.cpp 31 2023-06-12 20:17:58Z jb $
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

class RenderPass;

void FrameBufferHeadless::createFramebuffers() 
{
		    m_SwapChainFramebuffers.resize(m_App->GetSwapCount());

			VkImageView attachments[2];
			attachments[0] = m_RPO->m_IMO[0]->m_ImageView;
			attachments[1] = m_RPO->m_IMO[1]->m_ImageView;

            VkFramebufferCreateInfo framebufferInfo{};
            framebufferInfo.sType 			= VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
            framebufferInfo.renderPass 		= m_RPO->m_RenderPass;
            framebufferInfo.attachmentCount = 2;
            framebufferInfo.pAttachments 	= attachments;
            framebufferInfo.width 			= m_SCO->m_SwapChainExtent.width;
            framebufferInfo.height 			= m_SCO->m_SwapChainExtent.height;
            framebufferInfo.layers 			= 1;

            if (vkCreateFramebuffer( m_App->GetLogicalDevice(), 
                &framebufferInfo, nullptr, 
                &m_SwapChainFramebuffers[0]) != VK_SUCCESS) 
			{
                throw std::runtime_error("failed to create framebuffer!");
            }
			
            
            std::ostringstream  objtxt;
			objtxt << m_Name << " FrameBuffer#:" << 0 << std::ends;
			m_App->NameObject(VK_OBJECT_TYPE_FRAMEBUFFER, 
                (uint64_t)m_SwapChainFramebuffers[0], objtxt.str().c_str());
			

      
			

        
    }
