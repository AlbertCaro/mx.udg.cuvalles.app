import 'package:CUValles/models/new.dart';
import 'package:CUValles/screens/newdetail.dart';
import 'package:CUValles/values/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class NewsTab extends StatefulWidget {
  NewsTab({Key key}) : super(key: key);

  @override
  NewsState createState() => NewsState();

}

class NewsState extends State<NewsTab> {
  New selectedNew;

  List<dynamic> news = [
    New("Rector del CUValles rinde informe de actividades 2018", "25 Ene 2019", "Previo al informe fueron inauguradas diversas obras: el teatro al aire libre, una cancha de futbol, la plaza y el huerto solar", "CGCS", "http://cuvalles.udg.mx/sites/default/files/sin_titulo_0.png", """<div class="field field-name-field-sinopsis field-type-text field-label-hidden"><div class="field-items"><div class="field-item even">Previo al informe fueron inauguradas diversas obras: el teatro al aire libre, una cancha de futbol, la plaza y el huerto solar</div></div></div><div class="field field-name-field-cuerpo field-type-text-with-summary field-label-hidden"><div class="field-items"><div class="field-item even"><div class="rtejustify">
	La sostenibilidad; el cuidado del medio ambiente; la atención a la sociedad y el crecimiento de infraestructura, son cuatro de los motores que ha impulsado la administración del doctor José Luis Santana Medina, Rector del Centro Universitario de los Valles (CUValles), quien rindió su informe de actividades 2018 este miércoles 23 de enero.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	En pro de la sostenibilidad y el cuidado del medio ambiente destacó que las 2 mil 117 celdas solares instaladas en el campus, son capaces de producir mil 176 mega watts anuales de energía eléctrica, con lo cual el CUValles logrará producir 100 por ciento de la electricidad que requiere, después de que sean instalados los tableros de control. Esto representará un ahorro de 2.6 millones de pesos, declaró.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	CUValles cuenta, además, con 154 lámparas led para iluminación exterior, y sensores para el encendido de luz en espacios cerrados, con el fin de evitar el desperdicio.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Asimismo, el ahorro anual en agua asciende a 6 millones de litros, derivado del uso de mingitorios ecológicos y el tratamiento para riego de aguas residuales.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El programa de sostenibilidad incluye la implementación de buenas prácticas, como el aprovechamiento de la luz natural que ingresa por las ventanas; el uso eficiente del aire acondicionado y la contribución de la comunidad universitaria a la creación del Bosque de los Valles. Para este último fin, con apoyo del vivero Atizcoa, en agosto de 2018 se realizó la movilización “Arborétum”, que consistió en la plantación de 670 árboles al interior del campus.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Con el fin de promover la identidad regional, la salud, e incentivar el turismo local, se desarrolla el programa BISCI (Bienestar, Identidad, Salud, Cultura e Innovación) que, a través de entornos virtuales desarrollados por el equipo especializado del CUValles, permite a los usuarios dar un paseo ciclista por distintos escenarios de la región. Para este fin fue creada la plaza BISCI al exterior del edificio del Centro de Innovación en Tecnologías para el Aprendizaje (CITA), con bicicletas fijas equipadas con visores de realidad virtual y contador de kilómetros.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Con impacto en toda la región destacan los proyectos de Telemedicina, cuyo fin es acercar los servicios de salud a las comunidades apartadas; así como de Salud Ambiental, para integrar a la producción agrícola y la conservación de áreas naturales como instrumentos de prevención de enfermedades y creación de ambientes propicios para la salud.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	<strong>Números en infraestructura</strong></div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Durante la gestión del doctor Santana Medina, la infraestructura del CUValles fue duplicada: De 2013 a 2019 se concluyeron los trabajos de Las Velarias; el edificio académico; el Centro Regional para la Calidad Empresarial (CRECE); el CITA y la cancha de futbol 7 con graderías; así como la plaza Solar, el teatro Ágora (al aire libre) y el huerto solar. Los cuatro últimos fueron inaugurados por el Rector General de la UdeG, doctor Miguel Ángel Navarro Navarro, previo al informe.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	La plaza Solar es una infraestructura tipo pérgola, con módulos solares dispuestos en zigzag, los cuales conforman unas cubiertas con una superficie total de 985 metros cuadrados. Debajo de éstas, se diseñó un sitio de esparcimiento para el uso de toda la comunidad universitaria como espacio de trabajo y ocio durante la jornada académica. La inversión fue de un millón 392 mil pesos.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	La cancha de futbol 7 con graderías, abarca una superficie de 3 mil 153 metros cuadrados, y consta de cancha, gradería, sanitarios y vestidores. La obra significó una inversión de 11 millones de pesos.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Para el huerto solar, que implicó una inversión de 9 millones de pesos, se aprovecharon las ventajas del terreno, el cual, por cada metro cuadrado de suelo, producen al año mil 825 kilovatios-hora de energía. Abarca una superficie de 4 mil metros cuadrados y consta de mil 200 paneles, 26 inversores, lo que da como resultado una generación de 3 millones 337 mil 950 watts diarios, que representan un ahorro de un millón 462 mil 22 pesos anuales.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El teatro al aire libre Ágora se concibe como un inmueble que propicia el desarrollo educativo, humanístico, cultural, artístico, recreativo, cívico, deportivo y de salud, traduciéndose en el mejoramiento del nivel de vida de la comunidad universitaria. Abarca una superficie de mil 574 metros cuadrados. Tiene una capacidad para 250 personas y constituyó una inversión de 6 millones 200 mil pesos.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	En el acto inaugural de cada edificio participó también el Secretario de Innovación, Ciencia y Tecnología de Jalisco, doctor Alfonso Pompa Padilla, y el Vicerrector Ejecutivo de la UdeG, doctor Carlos Iván Moreno Arellano.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Posteriormente fueron visitadas obras que actualmente se encuentran en construcción, como los núcleos de Investigación y Posgrado, así como el de Servicios Universitarios, y la obra de vialidad y estacionamientos.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El Núcleo de Investigación y Posgrado albergará a los laboratorios de Mecatrónica; Desarrollo Tecnológico; Evaluación del Estado Nutricio y Dietética; Ciencias Biomédicas y Clínicas; Biotecnología; Señales de Audio y Video; Matemáticas; Electrónica y Control; Computación y Electrónica Digital; y Desarrollo, así como los centros de Inteligencia Artificial y de Nanociencia; Síntesis y Caracterización; Unidades de Genómica y Proteómica, y de Química y Bromatología; además de la Coordinación de Posgrados; los cubículos para profesores; aulas de posgrados, entre otros.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El Núcleo de Servicios a Universitarios abarcará las áreas de Salud Integral; cafetería y snack; sanitarios; gimnasio; vestidores; taller de arte; terraza; aula de usos múltiples; librería y tienda de identidad universitaria.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Con la puesta en marcha de estos núcleos se liberarán nueve aulas que ahora fungen como laboratorios y oficinas, y podrá incrementarse la matrícula en 700 estudiantes.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El CUValles cuenta con 4 mil 874 estudiantes, distribuidos en 18 carreras y seis posgrados; 95 por ciento procedentes de Jalisco y el resto de otros estados del país.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El crecimiento en infraestructura se hace sin descuidar la calidad académica, ya que 100 por ciento de las licenciaturas evaluables están acreditadas por los Comités Interinstitucionales para la Educación Superior (CIEES) y el Consejo para la Acreditación de la Educación Superior (Copaes). En cuanto a las maestrías, de las cinco nuevas, cuatro están en proceso de reconocimiento por parte del Consejo Nacional de Ciencia y Tecnología (Conacyt).</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Todos los profesores de tiempo completo cuentan con posgrado, y de 2013 a la fecha el porcentaje de maestros con Perfil Deseable del Programa de Desarrollo del Personal Docente (Prodep), de la Secretaría de Educación Pública, se incrementó 43 por ciento. Además, 40 por ciento de los profesores de tiempo completo forman parte del Sistema Nacional de Investigadores (SNI).</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El Rector General, doctor Miguel Ángel Navarro Navarro, reconoció el compromiso del CUValles con la comunidad que lo alberga, así como con sus estudiantes, lo cual es evidente en la certificación de sus carreras.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Recordó que este plantel inició con carreras posicionadas dentro del imaginario social como Derecho y Contaduría; posteriormente, empezó a introducir programas enfocados en crear demanda, como Agronegocios.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Señaló que la UdeG es la primera universidad pública estatal con 283 mil estudiantes, y 23 mil trabajadores administrativos y académicos. En total, son 15 comunidades distintas y un solo espíritu para la educación de los jóvenes. Todas son UdeG.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	El Secretario de Innovación, Ciencia y Tecnología, doctor Alfonso Pompa Padilla, destacó la importancia de la pasión por la innovación en ciencia y tecnología del centro, que es una brisa de aire fresco para una estrategia que es necesaria para todo el país.</div>
<div class="rtejustify">
	 </div>
<div class="rtejustify">
	Durante el acto protocolario del informe se otorgó el galardón “Cruz de Leones”, a José de Jesús Fregoso, estudiante de la licenciatura en Psicología.En 2017 el CUValles instauró este galardón en reconocimiento al estudiante con liderazgo transformador. Ese año lo recibió la alumna de la licenciatura en Tecnologías de la Información, Miriam Camarena. Y Moisés Anastasio Ruiz, alumno de la licenciatura en Educación, fue reconocido en 2018.</div>
<div class="rtejustify">
	 </div>""", "Noé Darío Mora Medina"),
    New("CUValles, una gran familia", "23 Ene 2019", "Personal directivo, administrativo, operativo y académico son ejemplo del compromiso universitario", "Alberto Caro Navarro", "http://cuvalles.udg.mx/sites/default/files/da7a6682.jpg", "http://cuvalles.udg.mx/sites/default/files/da7a6682.jpg", "Noé Darío Mora Medina"),
    New("LEAL, espacio de aprendizaje y conexión con el entorno", "22 Ene 2019", "El Laboratorio Educativo al Aire Libre contará con 3.5 hectáreas para el desarrollo de proyectos educativos, sociales y tecnológicos.", "Alberto Caro Navarro", "http://cuvalles.udg.mx/sites/default/files/da7a7662.jpg", "http://cuvalles.udg.mx/sites/default/files/da7a6682.jpg", "Noé Darío Mora Medina"),
    New("Sustentabilidad a prueba", "21 Ene 2019", "Desde el inicio de su gestión en 2013, como rector del Centro Universitario de los Valles (CUValles), José Luis Santana Medina, puso en marcha el programa Campus Sustentable- Campus Responsable (PCSCR), donde se establecían una serie de acciones en materia ambiental, en los rubros de energía, agua y residuos.", "Alberto Caro Navarro", "http://cuvalles.udg.mx/sites/default/files/da7a4194.jpg", "http://cuvalles.udg.mx/sites/default/files/da7a6682.jpg", "Noé Darío Mora Medina"),
  ];

  List<dynamic> showedList = [];

  NewsState() {
    showedList = news;
    selectedNew = showedList[0];
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color: LIST_BACKGROUND_COLOR,
            child: ListView.builder(
              reverse: false,
              itemCount: this.showedList.length,
              itemBuilder: listBuilder,
            ),
          ),
        ),
        Device.get().isTablet && selectedNew != null ? Expanded (
          flex: 2,
          child: NewDeatil(
            newObject: selectedNew,
          )
        ) : Container()
      ],
    );
  }

  Widget listBuilder (BuildContext, int index) => ItemList(
    newObject: this.showedList[index],
    onTap: () {
      if (Device.get().isTablet){
        selectedNew = this.showedList[index];
        setState(() {});
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewDeatil(newObject: this.showedList[index])
          )
        );
      }
    },
  );

}

class ItemList extends StatelessWidget {
  ItemList({this.newObject, this.onTap});
  final New newObject;
  Function onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(this.newObject.photo),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 90),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.7),
                    Color.fromRGBO(0, 0, 0, 0.7),
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0, 0.5),
                    Color.fromRGBO(0, 0, 0, 0.4)
                  ]
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.newObject.title,
                      style: TextStyle(
                      color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        this.newObject.resume,
                        style: TextStyle(
                        color: Colors.white70,
                          fontSize: 14
                        ),
                      ),
                    ),
                    Text(
                      this.newObject.date,
                      style: TextStyle(
                      color: Colors.white54,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        )
      ),
    );
  }
}