module AS4dim(clk,oGmi,oGmd,ov1i,ov1d);
input clk;
  
   output reg signed [15:0] oGmi;
   output reg signed [15:0] oGmd;
   output reg signed [15:0] ov1i;
   output reg signed [15:0] ov1d;
  
    //initial codition
     reg signed [31:0] v1=32'h00000000;       //0
     reg signed [31:0] u1=32'h00000000;       //0
     reg signed [31:0] c=32'h00000000;         //0
	 reg signed [31:0] sm=32'h00000000;        //0
	 reg signed [31:0] Gm=32'h00000000;        //0
	 reg signed [31:0] z=32'h00000000;        //0
	 
	 reg signed [31:0] testv1;       
	 reg signed [31:0] testu1;
	 reg signed [31:0] testsm;
	 reg signed [31:0] testGm;
     
          //parameters value 
      reg signed [31:0] z1=32'h00440000;                   //68
	  reg signed [31:0] mz1=32'hffbc0000;                   //-68
      reg signed [31:0] z2=32'h00390000;                   //57
	  reg signed [31:0] mz2=32'hffc70000;                   //-57
	  reg signed [31:0] mz3=32'hffee8000;                  //-17.5
	  
      //reg signed [31:0] c0=32'hffbf0000;                  //-65
      //reg signed [31:0] d=32'h00060000;                    //6
	  
	  reg signed [31:0] c0=32'hffce0000;                //-50
      reg signed [31:0] d=32'h00018000;                  //1.5
	  

      reg signed [31:0] vth=32'h001e0000;                     //30
     
	  
        wire signed [31:0] b1,b2,b3,b4;                                                               //out of adder 
        reg signed [31:0] ib1,ib2,ib3,ib4; 
		reg signed [31:0] inb1,inb2,inb3,inb4; 

        
		reg signed [31:0] r1,r2,r3;
		
		
		              //clock
             parameter s0=8'h00;                                                                    
             parameter s1=8'h01; 
             parameter s2=8'h02;
             parameter s3=8'h03;
             parameter s4=8'h04;
             parameter s5=8'h05;
             parameter s6=8'h06;
             parameter s7=8'h07;
             parameter s8=8'h08;
             parameter s9=8'h09; 
             parameter s10=8'h0a;
			 parameter s11=8'h0b;
			 parameter s12=8'h0c;
           
		    wire[7:0] p_s;
            reg [7:0] n_s=8'd0;
                   
		ADD A1(b1,ib1,inb1);
		ADD A2(b2,ib2,inb2);
		ADD A3(b3,ib3,inb3);
		ADD A4(b4,ib4,inb4);
       
  
            assign   p_s=n_s;
            always @(posedge clk)
            begin
            case (p_s)
////////////////////////////////////////			
         s0:begin			
            
			ib1<=~v1;
            inb1<=32'h00000001;
			
			ib2<=~Gm;
            inb2<=32'h00000001;
			
	
	     n_s<=s1;
	     end      		 
////////////////////////////////////////
	    s1:begin
		
	if(v1<=mz1)
    begin
    ib1<=b1;
    inb1<=mz1;
    ib2<=b1;
    inb2<=mz2;
    end 
  
    if(v1>mz1 && v1<=mz2)
    begin
    ib1<=v1;
    inb1<=z1;
    ib2<=b1;
    inb2<=mz2;
    end 
   
    if(v1>mz2)
    begin
    ib1<=v1;
    inb1<=z1;
    ib2<=v1;
    inb2<=z2;
    end
	
	
	    ib3<={c[28:0],1'b000};
		inb3<={c[30:0],1'b0};
		
	    if (b2[31]==1)
		begin
		ib4<={2'b11,b2[31:2]};
	    inb4<=32'h000008f6;
		end
		
		if (b2[31]==0)
		begin
		ib4<={2'b00,b2[31:2]};
	    inb4<=32'h000008f6;
		end
		
		
	
	
	
	     n_s<=s2;
	     end      
 //////////////////////////////
	    s2:begin
		
		r1<=b3;
		r2<=b4;

		ib3<=mz3;
	    inb3<=~u1;
		
		if (z[31]==1)
		begin
		ib4<={2'b1111,z[31:4]};
	    inb4<={2'b11111,z[31:5]};
		end
		
		if (z[31]==0)
		begin
		ib4<={2'b0000,z[31:4]};
	    inb4<={2'b00000,z[31:5]};
		end
		
		
	     n_s<=s3;
	     end      
 //////////////////////////////
	    s3:begin
		if (b1[31]==1 && b2[31]==1)
		begin
		ib1<={1'b1,b2[31:1]};
		inb1<={1'b1,b1[31:1]};
		end
		
		if (b1[31]==1 && b2[31]==0)
		begin
		ib1<={1'b0,b2[31:1]};
		inb1<={1'b1,b1[31:1]};
		end
		
		if (b1[31]==0 && b2[31]==1)
		begin
		ib1<={1'b1,b2[31:1]};
		inb1<={1'b0,b1[31:1]};
		end
		
		if (b1[31]==0 && b2[31]==0)
		begin
		ib1<={1'b0,b2[31:1]};
		inb1<={1'b0,b1[31:1]};
		end
		
		ib2<=b3;
		inb2<=32'h00000000;
		//inb2<={Gm[29:0],1'b00};
	   
	   
	   if (sm[31]==1)
		begin
		ib3<={2'b11,sm[31:2]};
	    inb3<=sm;
		end
		
		if (sm[31]==0)
		begin
		ib3<={2'b00,sm[31:2]};
	    inb3<=sm;
		end
	
	    ib4<=b4;
		inb4<=32'hffffff9d;
	
	
	     n_s<=s4;
	     end      
 //////////////////////////////
	    s4:begin
        
		ib3<=~b3;
		inb3<=32'h00000001;
 
        ib1<=~u1;
		inb1<=32'h00000001;
   
        r3<=b1;
 
      n_s<=s5;
	     end      
 //////////////////////////////
	    s5:begin
		
		ib1<=r3;
	    inb1<=b2;
		
		ib3<=b4;
		inb3<=b3;
		
		ib4<=r1;
	    inb4<=r2;
		
		if (v1[31]==1)
		begin
		ib2<={2'b11,v1[31:2]};
	    inb2<=b1;
		end
		
		if (v1[31]==0)
		begin
		ib2<={2'b00,v1[31:2]};
	    inb2<=b1;
		end
		
	     n_s<=s6;
	     end      
 //////////////////////////////
 	    s6:begin
		
		if (b1[31]==1)
		begin
		ib1<={6'b111111,b1[31:6]};
	    inb1<=v1;
		end
		
		if (b1[31]==0)
		begin
		ib1<={6'b000000,b1[31:6]};
	    inb1<=v1;
		end
		
		if (b2[31]==1)
		begin
		ib2<={11'b11111111111,b2[31:11]};
	    inb2<=u1;
		end
		
		if (b2[31]==0)
		begin
		ib2<={11'b00000000000,b2[31:11]};
	    inb2<=u1;
		end
		
		
		if (b3[31]==1)
		begin
		ib3<={6'b111111,b3[31:6]};
	    inb3<=sm;
		end
		
		if (b3[31]==0)
		begin
		ib3<={6'b000000,b3[31:6]};
	    inb3<=sm;
		end
		
		
		if (b4[31]==1)
		begin
		ib4<={6'b111111,b4[31:6]};
	    inb4<=Gm;
		end
		
		if (b4[31]==0)
		begin
		ib4<={6'b000000,b4[31:6]};
	    inb4<=Gm;
		end
		
		
		
		
	     n_s<=s7;
	     end      
//////////////////////////////
 	    s7:begin		 
		r1<=b1;
		
		ib1<=~c;
		inb1<=32'h00000001;
		
	     n_s<=s8;
	     end    		
 //////////////////////////////
 	    s8:begin
		
		testv1<=r1;
	    testu1<=b2;
		testsm<=b3;
		testGm<=b4;


//////////////////synaps
if (v1[31]==1)
begin
	   ib2<=32'h00000000;
	   inb2<=32'h00000000;
end

//////////////////////////	  

if (v1[31]==0)

begin

if (v1<=32'h00002400)
     begin
       ib2<=32'h00000000;
	   inb2<=32'h00000000;
end
	 
if ((32'h00002400<v1)&&(v1<=32'h00021f80))
     begin
	 
		ib2<=32'hffffede0;
		inb2<={v1[30:0],1'b0};
end

if (32'h00021f80<v1)
     begin
       ib2<=32'h00000000;
	   inb2<=32'h00010000;
end
end

///////////////////////////
		
		if (sm[31]==1 && b1[31]==1)
		begin
		ib1<={1'b1,b1[31:1]};
		inb1<={1'b1,sm[31:1]};
		end
		
		if (sm[31]==1 && b1[31]==0)
		begin
		ib1<={1'b0,b1[31:1]};
		inb1<={1'b1,sm[31:1]};
		end
		
		if (sm[31]==0 && b1[31]==1)
		begin
		ib1<={1'b1,b1[31:1]};
		inb1<={1'b0,sm[31:1]};
		end
		
		if (sm[31]==0 && b1[31]==0)
		begin
		ib1<={1'b0,b1[31:1]};
		inb1<={1'b0,sm[31:1]};
		end
		
		
	     n_s<=s9;
	     end      
 //////////////////////////////
 
 	    s9:begin
		
		z<=b2;
		
	    ib1<=b1;
		inb1<=32'h00000290;
		
	     n_s<=s10;
	     end      
 //////////////////////////////
 
 	    s10:begin
		
		if (b1[31]==1)
		begin
		ib1<={6'b111111,b1[31:6]};
	    inb1<=c;
		end
		
		if (b1[31]==0)
		begin
		ib1<={6'b000000,b1[31:6]};
	    inb1<=c;
		end
		
		if (testv1>=vth)
               begin
                testv1<=c0;
                testu1<=testu1+d;
                   end	
		 
	     n_s<=s11;
	     end      
 //////////////////////////////
 
 	    s11:begin

		    v1<=testv1;
            u1<=testu1;
		    sm<=testsm;
		    Gm<=testGm;
		    c<=b1;
		
	     n_s<=s12;
	     end      

 //////////////////////////////
        s12:begin
		
     	     oGmd<=Gm[15:0];
			 oGmi<=Gm[31:16];
			 ov1d<=v1[15:0];
			 ov1i<=v1[31:16];
			 
         n_s<=s0;
                    end 
					
///////////////////////////////////////					
               endcase
                end
          
           endmodule 	   					


















































  
  