class MapTricks {
  const MapTricks._();

  static List<Map<String, dynamic>> convertDynamicToListMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      // verifica se o valor já é um Map<String, dynamic>
      return [value];
    } else if (value is List) {
      // verifica se o valor é uma lista
      List<Map<String, dynamic>> result = [];
      for (var item in value) {
        // itera sobre cada item da lista
        if (item is Map<String, dynamic>) {
          // se o item já for um Map<String, dynamic>, adiciona na lista result
          result.add(item);
        } else if (item is List) {
          // se o item for uma lista, chama a função recursivamente para converter cada item da lista em um Map<String, dynamic>
          List<Map<String, dynamic>> nestedResult =
              convertDynamicToListMap(item);
          result.addAll(nestedResult);
        } else {
          // se o item não for nem um Map<String, dynamic> nem uma lista, retorna a lista vazia
          return [];
        }
      }
      return result;
    } else {
      // se o valor não for nem um Map<String, dynamic> nem uma lista, retorna a lista vazia
      return [];
    }
  }
}
