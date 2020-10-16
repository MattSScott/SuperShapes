//http://paulbourke.net/geometry/supershape/
//Credit to Prof. Shiffman - https://thecodingtrain.com/CodingChallenges/026-supershape3d.html

int RES = 40;
float r = width;
float tinc = PI / RES;
float pinc = TWO_PI / RES;
//SUPERSHAPE PARAMETERS
float a = 1.0;
float b = 1.0;
float n1 = 0.2;
float n2 = 1.7;
float n3 = 1.7;
float m = 1.0;
//SUPERSHAPE PARAMETERS
float mchange = 0;

void setup() {
  size(800, 800, P3D);
}

void draw() {
  translate(width/2, height/2, height/2);
  rotateY(PI/2+0.5);
  rotateX(-PI/2);
  background(0);
  drawSphere();
  m = map(sin(mchange), -1, 1, 0, 7);
  mchange += 0.02;
}

void drawSphere() {
  stroke(100);
  for (float theta=0; theta<PI+tinc; theta+=tinc) {
    beginShape(TRIANGLE_STRIP);
    float r2 = superR(theta);
    float ntheta = theta + tinc;
    float r2n = superR(ntheta);
    for (float phi=0; phi<TWO_PI+pinc; phi+=pinc) {
      float r1 = superR(phi);
      
      float x = (r1 * r2 * sin(theta) * cos(phi)) * r;
      float y = (r1 * r2 * sin(theta) * sin(phi)) * r;
      float z = (r2 * cos(theta)) * r;
      
      float xn = (r1 * r2n * sin(ntheta) * cos(phi)) * r;
      float yn = (r1 * r2n * sin(ntheta) * sin(phi)) * r;
      float zn = (r2n * cos(ntheta)) * r;
      
      vertex(x, y, z);
      vertex(xn, yn, zn);
    }
    endShape(CLOSE);
  }
}

float superR(float theta){
  float t1 = pow(abs(1/a * cos(m * theta / 4)), n2);
  float t2 = pow(abs(1/b * sin(m * theta / 4)), n3);
  return pow(t1 + t2, -1/n1);
}
