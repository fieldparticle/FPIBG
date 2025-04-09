function pnum = AddParticleData(obj,X,Y,Z,RR,velAry,accr,acca,Subs)

      
 	
    pnum=obj.AddParticleAry(X,Y,Z,RR,velAry,-1.9,0.0,"He");
    vel_temp = obj.CalcTAccu(pnum,obj.TK);
   
    obj.p(pnum).molar_matter = obj.sl(obj.p(pnum).sln).molar_matter;

    ;
end