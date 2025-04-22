
float border_y= height/20;
float border_x= width/40;


void draw(){

  
for (float i = width/40 ; i < width; i = i+width/40) {
  for (float j = 0; j < height/40 * 29; j = j+height/20) {
    
     //verander dit later in "HOSPITALISATIES" vanuit de array
float d = i;
float p = map(d,0,5000,0,255);
fill(random(p));
   
    square(i,j,height/25);
  }
}
}
