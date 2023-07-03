// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:farmtrack/src/common_widgets/common_padding.dart';
import 'package:farmtrack/src/features/farms/models/animal_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_animals_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_model.dart';
import 'package:farmtrack/src/features/farms/view_models/farm_view_model.dart';
import 'package:farmtrack/src/validators/validator_mixin.dart';

class EditFarmView extends StatefulWidget {
  final int? index;
  final FarmAnimalsModel? farmAnimal;

  const EditFarmView({
    super.key,
    this.index,
    this.farmAnimal,
  });

  @override
  State<EditFarmView> createState() => _EditFarmViewState();
}

class _EditFarmViewState extends State<EditFarmView> with ValidatorMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _farmNameController;
  late List<TextEditingController> _tagController;

  int _generateID() {
    var uuid = const Uuid();

    // Generate a unique v4 UUID
    String uniqueId = uuid.v4();
    // Convert string to integer
    int uniqueIntId = uniqueId.hashCode;

    return uniqueIntId;
  }

  Future<void> _createOrEditFarmAnimals(BuildContext context) async {
    int idFarm = widget.farmAnimal?.id ?? _generateID();

    final listAnimals = <AnimalModel>[];

    for (int i = 0; i < _tagController.length; i++) {
      FarmModel farm = FarmModel(
        id: idFarm,
        name: _farmNameController.text.trim(),
      );
      listAnimals.add(
        AnimalModel(
          id: idFarm,
          farm: farm,
          tag: _tagController[i].text.trim(),
        ),
      );
    }

    FarmAnimalsModel farmAnimal = FarmAnimalsModel(
      id: idFarm,
      name: _farmNameController.text.trim(),
      animals: listAnimals,
    );

    if (widget.index != null && widget.farmAnimal != null) {
      context.read<FarmViewModel>().update(widget.index!, farmAnimal);
    } else {
      context.read<FarmViewModel>().create(farmAnimal);
    }
  }

  void _initFields() {
    if (widget.farmAnimal != null) {
      _farmNameController = TextEditingController(
        text: widget.farmAnimal!.name,
      );
      _tagController = widget.farmAnimal!.animals
          .map((value) => TextEditingController(text: value.tag))
          .toList();
    } else {
      _farmNameController = TextEditingController();
      _tagController = [TextEditingController()];
    }
  }

  @override
  void initState() {
    super.initState();
    _initFields();
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    for (var controller in _tagController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Remove focus of TextFields
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.farmAnimal != null
              ? const Text('Atualizar animal da fazenda')
              : const Text('Criar animal da fazenda'),
        ),
        body: CommonPadding(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text('Nome da Fazenda'),
                      TextFormField(
                        controller: _farmNameController,
                        decoration: const InputDecoration(hintText: 'Nome'),
                        validator: (String? value) => validateName(value),
                      ),
                      const SizedBox(height: 24.0),
                      const Text('Tag do animal'),
                      ..._getTextFields(),
                      const SizedBox(height: 12.0),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _tagController.add(TextEditingController());
                            });
                          },
                          child: const Text('Adicionar mais tags'),
                        ),
                      ),
                      const SizedBox(height: 320.0),
                      CommonPadding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _createOrEditFarmAnimals(context);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Salvar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < _tagController.length; i++) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _tagController[i],
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(hintText: 'Tag ${i + 1}'),
                  validator: (String? value) => validateTag(value),
                ),
              ),
              const SizedBox(width: 16),
              _tagController.length > 1
                  ? IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          _tagController.removeAt(i);
                        });
                      },
                    )
                  : const IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: null,
                    ),
            ],
          ),
        ),
      );
    }
    return textFields;
  }
}
