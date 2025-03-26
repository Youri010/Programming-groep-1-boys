float border_y= height/20;
float border_x= width/40;


void draw(){

  
for (float i = width/40 ; i < width; i = i+width/40) {
  for (float j = 0; j < height/30 * 29; j = j+height/20) {
    
     //verander dit later in "HOSPITALISATIES" vanuit de array
float d = i;
float p = map(d,0,5000,0,255);
fill(random(p));
   
    square(i,j,height/25);





   
  }
}

for (int x = 0; x < width; x++) {
    float inter = map(x, 0, width, 0, 1);
    color c = lerpColor(color(255, 0, 0), color(0, 0, 255), inter);

//rect(500, height-50, 500, 50);
stroke(c);
line(500,height, width/2, height-50);

}

}
