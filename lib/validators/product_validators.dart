class ProductValidators {
  String validateImages(List images) {
    if (images.isEmpty) return "Adicione imagens do produto";
    return null;
  }

  String validateTitle(String value) {
// validator: (value) {
    // bool isEmpty = value.trim().isEmpty;
    // bool isInvalid = value.trim().length < 2;
    if (value.trim().isEmpty || value.trim().length < 2) {
      return 'Informe um título válido com no mínimo 2 caracteres!';
    }
    return null;
    // },
    // if (text.isEmpty) return "Preencha o título do produto";
    // return null;
  }

  String validateDescription(String text) {
    if (text.isEmpty) return "Preencha a descrição do produto";
    return null;
  }

  String validateCurrency(String value) {
    if (value.trim() != '') {
      double val = double.tryParse(value);
      if (val != null) {
        if (!value.contains(".") || value.split(".")[1].length != 2)
          return 'Utilize 2 casas decimais utilizando "." e nao ","';
      } else {
        return "Preço inválido";
      }
    }
    return null;
  }
}
