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

var get_all_cells_included_on_submit = function(input_cells) {
  // included cells encompass all cells containing previously placed tiles,
  // on the axis of the submitted tiles,
  // touching at least one submitted tile
  var included_cells = []
  // var included_cells = sort_input_cells(input_cells);
  // console.log(included_cells);
  var top_left_cell = find_top_left_tile_cell(input_cells);
  var bottom_right_cell = find_bottom_right_tile_cell(input_cells);
  var orientation;
  // redundant for now...
  console.log(top_left_cell.x+', '+top_left_cell.y);
  console.log(bottom_right_cell.x+', '+bottom_right_cell.y);
  if (top_left_cell.x == bottom_right_cell.x) { orientation = 'vertical' }
  if (top_left_cell.y == bottom_right_cell.y) { orientation = 'horizontal' }
  if (top_left_cell.x == bottom_right_cell.x && top_left_cell.y == bottom_right_cell.y) { orientation = 'one cell'}
  console.log(orientation);
  if (orientation == 'vertical') {
    var top_cell = top_left_cell;
    var bottom_cell = bottom_right_cell;
    // look up from top cell
    var cell_above = $('.cell[data-y="'+(top_cell.y-1)+'"][data-x="'+top_cell.x+'"]');
    while (tile_exists_at(cell_above)) {
      top_cell = new Cell(cell_above);
      cell_above = $('.cell[data-y="'+(top_cell.y-1)+'"][data-x="'+top_cell.x+'"]');
    }
    // look down from bottom cell
    var cell_below = $('.cell[data-y="'+(bottom_cell.y+1)+'"][data-x="'+bottom_cell.x+'"]');
    while (tile_exists_at(cell_below)) {
      bottom_cell = new Cell(cell_below);
      cell_below = $('.cell[data-y="'+(bottom_cell.y+1)+'"][data-x="'+bottom_cell.x+'"]');
    }
    console.log(top_cell);
    console.log(bottom_cell);    
  
  } else if (orientation == 'horizontal') {
    var left_cell = top_left_cell;
    var right_cell = bottom_right_cell;
    // look left of left-most cell
    var cell_left = $('.cell[data-x="'+(left_cell.x-1)+'"][data-y="'+left_cell.y+'"]');
    while (tile_exists_at(cell_left)) {
      left_cell = new Cell(cell_left);
      cell_left = $('.cell[data-x="'+(left_cell.x-1)+'"][data-y="'+left_cell.y+'"]');
    }
    // look right of right-most cell
    var cell_right = $('.cell[data-x="'+(right_cell.x+1)+'"][data-y="'+right_cell.y+'"]');
    while (tile_exists_at(cell_right)) {
      right_cell = new Cell(cell_right)
      cell_right = $('.cell[data-x="'+(right_cell.x+1)+'"][data-y="'+right_cell.y+'"]');
    }
    console.log(left_cell);
    console.log(right_cell);  
  } else if (orientation == 'one cell') { // handle this somehow??

  } else {
    alert('invalid cell arrangement')
  }
}

var tile_exists_at = function(cell) {
  if (cell.children().length > 0) { return true }
  return false;
};

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

  function compare_x(cell1, cell2) {
    if (cell1.x < cell2.x) { return -1 } // cell1 is left of cell2 (greater)
    if (cell1.x > cell2.x) { return 1 } // cell1 is right of cell2 (lesser)   
    return 0; // cell1 and cell2 are on the same x axis
  }

  function compare_y(cell1, cell2) {
    if (cell1.y < cell2.y) { return -1 } // cell1 is above cell2 (greater) 
    if (cell1.y > cell2.y) { return 1 } // cell1 is below cell2 (lesser)
    return 0; // cell1 and cell2 are on the same y axis
  }

  function sort_input_cells(input_cells) {
    input_cells = input_cells.map(function(index, cell) { return new Cell(cell) });
    input_cells.sort(compare_x);
    input_cells.sort(compare_y);
    return input_cells;
  }

  var find_top_left_tile_cell = function(input_cells) {
    return sort_input_cells(input_cells)[0]
  };
  var find_bottom_right_tile_cell = function(input_cells) {
    return sort_input_cells(input_cells)[input_cells.length-1]
  };

var tiles_spell_valid_word = function() {
  return true
};

// Get array of new_words formed by tiles
var get_new_words = function() {};


// SubmitTurn event handler:
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
