mixin ValidatorMixin {
  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'O nome da fazenda é obrigatório!';
    } else if (name.length < 3) {
      return 'O nome da fazenda precisa ter mais de 2 letras!';
    }
    return null;
  }

  String? validateTag(String? tag) {
    if (tag == null || tag.isEmpty) {
      return 'A tag de identificação é obrigatória!';
    } else if (tag.length > 15) {
      return 'A tag possui no maximo 15 digitos!';
    }
    return null;
  }
}
