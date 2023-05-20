import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class WorkoutPlan {
  final String name;
  final List<ExercisePlan> exercises;

  const WorkoutPlan({
    required this.name,
    required this.exercises,
  });

  static WorkoutPlan noWorkoutPlan() {
    return const WorkoutPlan(
      name: 'Descanso',
      exercises: [ExercisePlan(name: 'Caminhada')],
    );
  }
}

class ExercisePlan {
  final String name;

  const ExercisePlan({
    required this.name,
  });
}

class WeekPlan {
  final String name;
  final List<Instruction> instructions;

  const WeekPlan({
    required this.name,
    required this.instructions,
  });

  static WeekPlan noWeekPlan() =>
      const WeekPlan(name: 'Descanso', instructions: []);
}

class Instruction {
  final int sets;
  final int reps;
  final String name;

  const Instruction({
    required this.sets,
    required this.reps,
    required this.name,
  });

  @override
  String toString() {
    return '${sets}X$reps ($name)';
  }
}

class Workout {
  final DateTime dateTime;
  final WeekPlan weekPlan;
  final WorkoutPlan workoutPlan;
  late final List<Exercise> exercises;

  Workout({
    required this.dateTime,
    required this.weekPlan,
    required this.workoutPlan,
  }) {
    exercises = workoutPlan.exercises
        .map((exercisePlan) => Exercise(
              exercisePlan: exercisePlan,
              done: false,
            ))
        .toList();
  }
}

class Exercise {
  final ExercisePlan exercisePlan;
  bool done;

  Exercise({
    required this.exercisePlan,
    required this.done,
  });

  toggleDone() {
    done = !done;
  }
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<Workout> _selectedEvent;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<WeekPlan> weekPlans = [
    const WeekPlan(
      name: 'Primeira Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 2,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Segunda Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 2,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Terceira Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 3,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Quarta Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 3,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Quinta Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 3,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Sexta Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 1,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 3,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Sétima Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 1,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 3,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
    const WeekPlan(
      name: 'Oitava Semana',
      instructions: [
        Instruction(
          sets: 1,
          reps: 12,
          name: 'Sinalização',
        ),
        Instruction(
          sets: 3,
          reps: 5,
          name: 'Carga alta',
        ),
        Instruction(
          sets: 2,
          reps: 12,
          name: 'Conexão muscular',
        ),
      ],
    ),
  ];

  List<WorkoutPlan> workoutPlans = [
    const WorkoutPlan(
      name: 'Treino A',
      exercises: [
        ExercisePlan(
          name: 'DESENVOLVIMENTO ARTICULADO NEUTRO',
        ),
        ExercisePlan(
          name: 'ELEVAÇÃO FRONTAL PEGADA NEUTRA COM HALTER',
        ),
        ExercisePlan(
          name: 'SUPINO INCLINADO MAQUINA',
        ),
        ExercisePlan(
          name: 'SUPINO INCLINADO COM BARRA',
        ),
        ExercisePlan(
          name: 'SUPINO RETO MAQUINA',
        ),
        ExercisePlan(
          name: 'VOADOR',
        ),
        ExercisePlan(
          name: 'ROSCA DIRETA NO CROSS COM BARRA W',
        ),
        ExercisePlan(
          name: 'ROSCA MARTELO COM HALTER',
        ),
      ],
    ),
    const WorkoutPlan(
      name: 'Treino B',
      exercises: [
        ExercisePlan(
          name: 'BANCO ABDUTOR',
        ),
        ExercisePlan(
          name: 'LEG PRESS',
        ),
        ExercisePlan(
          name: 'BANCO EXTENSOR',
        ),
        ExercisePlan(
          name: 'AGACHAMENTO NO HACK MACHINE',
        ),
        ExercisePlan(
          name: 'CADEIRA FLEXORA',
        ),
        ExercisePlan(
          name: 'MESA FLEXORA',
        ),
        ExercisePlan(
          name: 'PANTURRILHA EM PÉ NO SMITH',
        ),
        ExercisePlan(
          name: 'PANTURRILHA SENTADO',
        ),
      ],
    ),
    const WorkoutPlan(
      name: 'Treino C',
      exercises: [
        ExercisePlan(
          name: 'PUXADOR FRENTE BARRA GRANDE PEGADA NEUTRA (BARRA NOVA)',
        ),
        ExercisePlan(
          name: 'PUXADOR BARRA PEQUENA PEGADA NEUTRA (BARRA NOVA)',
        ),
        ExercisePlan(
          name: 'PUXADOR COM TRIANGULO OU PULL DOWN COM BARRA NO CROSS',
        ),
        ExercisePlan(
          name: 'PUXADOR COM BARRA MEDIA NEUTRA',
        ),
        ExercisePlan(
          name: 'REMADA CAVALINHO PEGADA ABERTA PRONADA',
        ),
        ExercisePlan(
          name: 'REMADA BAIXA PEGADA NEUTRA',
        ),
        ExercisePlan(
          name: 'REMADA ARTICULADA PEGADA ABERTA E PRONADA',
        ),
        ExercisePlan(
          name: 'REMADA UNILATERAL NA MAQUINA ARTICULADA',
        ),
      ],
    ),
    const WorkoutPlan(
      name: 'Treino D',
      exercises: [
        ExercisePlan(
          name: 'ELEVAÇÃO LATERAL COM HALTER',
        ),
        ExercisePlan(
          name: 'ELEVAÇÃO LATERAL NO CROSS',
        ),
        ExercisePlan(
          name: 'FACE PULL',
        ),
        ExercisePlan(
          name: 'CRUCIFIXO INVERSO NA MAQUINA',
        ),
        ExercisePlan(
          name: 'CRUCIFIXO INVERSO NO CROSS POLIA NA LINHA DO OMBRO',
        ),
        ExercisePlan(
          name: 'TRICEPS CORDA',
        ),
        ExercisePlan(
          name: 'TRICEPS PULLEY BARRA W',
        ),
        ExercisePlan(
          name: 'TRICEPS ARREMESSO COM BARRA W',
        ),
      ],
    ),
    const WorkoutPlan(
      name: 'Treino E',
      exercises: [
        ExercisePlan(
          name: 'BANCO ABDUTOR',
        ),
        ExercisePlan(
          name: 'LEG PRESS',
        ),
        ExercisePlan(
          name: 'BANCO EXTENSOR',
        ),
        ExercisePlan(
          name: 'AGACHAMENTO NO HACK MACHINE',
        ),
        ExercisePlan(
          name: 'CADEIRA FLEXORA',
        ),
        ExercisePlan(
          name: 'MESA FLEXORA',
        ),
        ExercisePlan(
          name: 'PANTURRILHA EM PÉ NO SMITH',
        ),
        ExercisePlan(
          name: 'PANTURRILHA SENTADO',
        ),
      ],
    ),
    const WorkoutPlan(
      name: 'Treino F',
      exercises: [
        ExercisePlan(
          name: 'ABDOMINAL PRANCHA',
        ),
        ExercisePlan(
          name: 'ABDOMINAL SUPRA',
        ),
        ExercisePlan(
          name: 'ABDOMINA ELEVAÇÃO DE PERNA',
        ),
        ExercisePlan(
          name: 'ABDOMINAL NA PARARELA ELEVAÇÃO DE PERNA FLEXIONADA',
        ),
        ExercisePlan(
          name: 'TRICEPS BARRA W',
        ),
        ExercisePlan(
          name: 'ROSCA SCOOT MAQUINA',
        ),
        ExercisePlan(
          name: 'ROSCA ALTERNADA COM HALTER',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier(_getEventForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvent.dispose();
    super.dispose();
  }

  Workout _getEventForDay(DateTime day) {
    if (day.weekday == 7) {
      return Workout(
        dateTime: _selectedDay,
        weekPlan: WeekPlan.noWeekPlan(),
        workoutPlan: WorkoutPlan.noWorkoutPlan(),
      );
    }

    return Workout(
      dateTime: _selectedDay,
      weekPlan: weekPlans[0],
      workoutPlan: workoutPlans[day.weekday - 1],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Treinos',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2023),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvent.value = _getEventForDay(selectedDay);
              });
            },
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Semanal',
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 0),
          Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedEvent.value.workoutPlan.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._selectedEvent.value.weekPlan.instructions
                      .map((instruction) => Text(
                            instruction.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      .toList()
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  ..._selectedEvent.value.exercises
                      .map(
                        (exercise) => InkWell(
                          onTap: () => setState(() {
                            exercise.toggleDone();
                          }),
                          child: Text(
                            toBeginningOfSentenceCase(
                              exercise.exercisePlan.name.toLowerCase(),
                              'pt_BR',
                            )!,
                            style: TextStyle(
                              fontSize: 15,
                              decoration: exercise.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
