// on submit of a board
//   verify that the current tiles are either all on the same row or column
//   verify that the current tiles touch at least one previously placed tile
//   verify that the current tiles spell a word(s) that exists in the dictionary
// if verifications pass
//   calculate score of the word(s) formed by the tiles
//   apply score to current player's total score
//   add/remove appropriate css classes,ids,attrs
//   transfer board to next turn

// validations
function tiles_are_inline(input_cells) {
  var x = $(input_cells[0]).data('x');
  var y = $(input_cells[0]).data('y');
  if (input_cells.length > 1) {
    for (var i = 1; i < input_cells.length; i++) {
      var cell_x = $(input_cells[i]).data('x');
      var cell_y = $(input_cells[i]).data('y');
      console.log('('+cell_x+', '+cell_y+') ?= ('+x+', '+y+')');
      if (cell_x != x && cell_y != y ) {
        return false;
      }
      x = cell_x;
      y = cell_y;
    }
  } else if (input_cells.lenth == 0) {return false}
  return true
}

var tiles_touch_prev = function() {
  return true
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
