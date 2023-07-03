// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:farmtrack/src/common_widgets/common_padding.dart';
import 'package:farmtrack/src/features/farms/view_models/farm_view_model.dart';
import 'package:farmtrack/src/features/farms/views/edit_farm_view.dart';
import 'package:farmtrack/src/routes/routes.dart';

class FarmView extends StatelessWidget {
  const FarmView({super.key});

  @override
  Widget build(BuildContext context) {
    final farms = context.watch<FarmViewModel>().value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de fazendas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(RoutesNew.settings);
            },
          ),
        ],
      ),
      body: CommonPadding(
        padding: const EdgeInsets.all(4.0),
        child: farms.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  context.read<FarmViewModel>().read();
                },
                child: ListView.builder(
                  itemCount: farms.length,
                  itemBuilder: (context, index) {
                    final farmAnimalData = farms[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditFarmView(
                              index: index,
                              farmAnimal: farmAnimalData,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              farmAnimalData.name[0].toUpperCase(),
                            ),
                          ),
                          title: Text(farmAnimalData.name),
                          subtitle: Text(
                            'quantidade de animais: ${farmAnimalData.animals.length} ',
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              context.read<FarmViewModel>().delete(index);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Text('A lista de fazendas está vazia.',
                style: Theme.of(context).textTheme.bodyLarge),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EditFarmView(),
            ),
          );
        },
      ),
    );
  }
}


// class FarmView extends StatelessWidget {
//   const FarmView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final farms = context.watch<FarmViewModel>().value;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lista de fazendas'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings_outlined),
//             onPressed: () {
//               Navigator.of(context).pushNamed(RoutesNew.settings);
//             },
//           ),
//         ],
//       ),
//       body: CommonPadding(
//         padding: const EdgeInsets.all(4.0),
//         child: farms.isNotEmpty
//             ? RefreshIndicator(
//                 onRefresh: () async {
//                   context.read<FarmViewModel>().read();
//                 },
//                 child: ListView.builder(
//                   itemCount: farms.length,
//                   itemBuilder: (context, index) {
//                     final farmAnimalData = farms[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => EditFarmView(
//                               index: index,
//                               farmAnimal: farmAnimalData,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Text(
//                               farmAnimalData.farm.name[0].toUpperCase(),
//                             ),
//                           ),
//                           title: Text(farmAnimalData.farm.name),
//                           subtitle: Text(
//                             'quantidade de animais: ${farmAnimalData.tag} ',
//                           ),
//                           trailing: IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                             onPressed: () {
//                               context.read<FarmViewModel>().delete(index);
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             : Text('A lista de fazendas está vazia.',
//                 style: Theme.of(context).textTheme.bodyLarge),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => const EditFarmView(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
