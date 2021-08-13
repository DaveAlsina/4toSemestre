import 'dart:io';
import 'dart:math';

class Punto {
  late double x;
  late double y;

  Punto(double mi_x, double mi_y){
    this.x = mi_x;
    this.y = mi_y;
  }

 
  

  double get_x() => this.x;
  void set_x(double mi_x) => x = mi_x;
  
  void set_y(double mi_y) => this.y = mi_y;
  double get_y() => this.y;

}

class Cuadrado {

	Punto p1 = new Punto(0,0);
	Punto p2 = new Punto(0,0);
	Punto p3 = new Punto(0,0);
	Punto p4 = new Punto(0,0);

  Cuadrado(Punto p){
     p1 = new Punto(p.x - 0.0005, p.y + 0.0005); // arriba a la izquierda
     p2 = new Punto(p.x + 0.0005, p.y + 0.0005); // arriba a la derecha
     p3 = new Punto(p.x - 0.0005, p.y - 0.0005); // abajo a la izquierda
     p4 = new Punto(p.x + 0.0005, p.y - 0.0005); // abajo a la derecha
  }
  
  Punto get_p1() => this.p1;
  Punto get_p2() => this.p2;
  Punto get_p3() => this.p3;
  Punto get_p4() => this.p4;

  bool is_inside(Punto p){
    bool cond1 = (p.get_x() >= this.get_p1().get_x()) & (p.get_y() <= this.get_p1().get_y());
    bool cond2 = (p.get_x() <= this.get_p4().get_x()) & (p.get_y() >= this.get_p4().get_y());

    if(cond1 & cond2){
      return true;
    }else{
      return false;
    }

  }
}

//-------------------- Main ------------------------------------------

void main(){
  Punto p_ini = new Punto(0,0);
  Cuadrado c = new Cuadrado(p_ini);
  List<Punto> recorrido = recorridoAleatorio(p_ini, 5);
  bool es_valido_cercado = validar_cercado(recorrido, c);
  print(es_valido_cercado);
}

//---------------------- Funciones -----------------------------------
List<Punto> recorridoAleatorio(Punto p, int N){
  List<Punto> recorrido = [];
  Random rnd = new Random();

  //const double pi = 3.1415926535897932;
  for(int i = 0; i < N;i++){
    double r_i = rnd.nextDouble()*0.0001;
    double th_i = rnd.nextDouble()*2*pi;

    Punto P_i = new Punto(r_i*cos(th_i), r_i*sin(th_i)); 
    recorrido.add(P_i);
  }

  return recorrido;
}

bool validar_cercado(List<Punto> r, Cuadrado cuad){
  for(var p in r){
    if(cuad.is_inside(p)){
      // Hacer print
      return true;
    }
  }
    return false;
}
