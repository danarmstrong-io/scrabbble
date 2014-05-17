// on submit of a board
//   verify that the current tiles are either all on the same row or column
//   verify that the current tiles touch at least one previously placed tile
//   verify that the current tiles spell a word(s) that exists in the dictionary
// if verifications pass
//   calculate score of the word(s) formed by the tiles
//   apply score to current player's total score
//   add/remove appropriate css classes,ids,attrs
//   transfer board to next turn

function Cell(input_cell) {
  this.x = $(input_cell).data('x');
  this.y = $(input_cell).data('y');
  this.letter = $($(input_cell).find('div.tile-letter')[0]).text();
  this.value = $($(input_cell).find('div.tile-value')[0]).text();
}

// validations
function tiles_are_inline(input_cells) {
  if (input_cells.length > 1) { // if more than one cell has been placed on the board
    var x = $(input_cells[0]).data('x');
    var y = $(input_cells[0]).data('y');
    var x1 = $(input_cells[1]).data('x');
    var y1 = $(input_cells[1]).data('y');
    if (x == x1) {
      if (input_cells.length == 2) {return true}
      for (var i = 2; i < input_cells.length; i++) {
        var cell_x = $(input_cells[i]).data('x');
        if (cell_x != x) {return false}
      }
    } else if (y == y1) {
      if (input_cells.length == 2) {return true}
      for (var i = 2; i < input_cells.length; i++) {
        var cell_y = $(input_cells[i]).data('y');
        if (cell_y != y) {return false}
      }
    } else { return false }
  } else if (input_cells.length == 0) { return false }
  return true
}

var tiles_touch_prev = function() {
  return true
};

// helpers: TOUCHING, FIND_TOP_LEFT_TILE, FIND_BOTTOM_RIGHT_TILE
  var touching = function(cell1, cell2) { // cell is a jquery object wrapping a <td> element
    if (cell1.x == cell2.x) { // on the same x-axis
      console.log( Math.abs(cell1.y.to_i - cell2.y) );
      if ( Math.abs(cell1.y - cell2.y) == 1 ) {return true}// checks for adjacency on y axis
    }
    else if ( cell1.y == cell2.y ) { // on the same y-axis
      if ( Math.abs(cell1.x - cell2.x) == 1 ) {return true}// checks for adjacency on the x axis
    }
    return false;
  };

  var find_top_left_tile = function(input_cells) {

  };
  var find_bottom_right_tile = function(input_cells) {

  };

var tiles_spell_valid_word = function() {
  return true
};

// Get array of new_words formed by tiles
var get_new_words = function() {};


// Submit event handler:
var on_turn_submit = function (f) { $('#submit_turn').on( 'click', f ) };
var validate_turn = function (e) {
  e.preventDefault();
  var input_cells = $('#board div.tile.ui-draggable').parent()
  if (tiles_are_inline(input_cells) && 
      tiles_touch_prev(input_cells) && 
      tiles_spell_valid_word(input_cells) ) { alert('VALIDATIONS PASS!') }  
  else { alert("VALIDATIONS DO NOT PASS!") }
}

// runtime code
$(function(){
  on_turn_submit( validate_turn );

});
