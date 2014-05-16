var input_cells = $('#board div.tile.ui-draggable').parent();
var cells_oriented = function(input_cells) {
  var x = $(input_cells[0]).data('x');
  var y = $(input_cells[0]).data('y');
  if (input_cells.length > 1)
    for (var i = 1; i < input_cells.length; i++) {
      var cell_x = $(input_cells[i]).data('x');
      var cell_y = $(input_cells[i]).data('y');
      console.log('('+cell_x+', '+cell_y+') ?= ('+x+', '+y+')');
      if (cell_x != x && cell_y != y ) {
        console.log("FAIL!!!!")
        return false;
      }
    }
  return true
};
console.log(cells_oriented(input_cells));
