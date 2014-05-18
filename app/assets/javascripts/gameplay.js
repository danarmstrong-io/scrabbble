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
    var top_left_cell = find_top_left_tile_cell(input_cells);
    var bottom_right_cell = find_bottom_right_tile_cell(input_cells);
    var orientation = get_orientation( input_cells );
    // redundant for now...
    console.log(top_left_cell.x+', '+top_left_cell.y);
    console.log(bottom_right_cell.x+', '+bottom_right_cell.y);
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
        console.log('--inside get submitted---')
        console.log(top_cell);
        console.log(bottom_cell);
        included_cells = get_cells_between_range(top_cell, bottom_cell, orientation)
        console.log(included_cells)

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
        console.log('--inside get submitted---')
        console.log(left_cell);
        console.log(right_cell);
        included_cells = get_cells_between_range(left_cell, right_cell, orientation)
        console.log(included_cells)
    } else if (orientation == 'one cell') { // handle this somehow??

    } else {
        alert('invalid cell arrangement')
    }
    return included_cells;
}

var tiles_touch_prev = function(input_cells) {
    var tiles_touch = false
    var included_cells = get_all_cells_included_on_submit(input_cells);
    if (no_gaps_exist(included_cells)) {
        // var orientation = get_orientation(included_cells)
        var orientation;
        if (included_cells[0].y == included_cells[1].y) {orientation = 'horizontal'}
        if (included_cells[0].x == included_cells[1].x) {orientation = 'vertical'}
        console.log(orientation);
        if (orientation == 'horizontal') {
            $.each(included_cells, function(index, cell) {
                if ( tile_exists_at($('.cell[data-y="'+(cell.y-1)+'"][data-x="'+cell.x+'"]')) ||  // above
                    tile_exists_at($('.cell[data-y="'+(cell.y+1)+'"][data-x="'+cell.x+'"]'))  ) {// below
                    tiles_touch = true;
                }
            });
        } else if (orientation == 'vertical') {
            $.each(included_cells, function(index, cell) {
                if ( tile_exists_at($('.cell[data-x="'+(cell.x-1)+'"][data-y="'+cell.y+'"]')) ||   // left
                    tile_exists_at($('.cell[data-x="'+(cell.x+1)+'"][data-y="'+cell.y+'"]'))  ) { // right
                    console.log("TRUE");
                    tiles_touch = true;
                } else if ($('.cell[data-x="'+(cell.x)+'"][data-y="'+cell.y+'"]').hasClass('ui-draggable') != true) {
                  tiles_touch = true;
                }
            });
        }
    }
    return tiles_touch
};

// helpers: TOUCHING, FIND_TOP_LEFT_TILE, FIND_BOTTOM_RIGHT_TILE, TILE_EXISTS_AT, GET_CELLS_BETWEEN_RANGE, GET_ORIENTATION
var no_gaps_exist = function( included_cells ) {
    var no_gaps = true
    $.each(included_cells, function(index, cell) {
        if ($('.cell[data-x="'+cell.x+'"][data-y="'+cell.y+'"]').children().length == 0) { no_gaps = false} } );
    return no_gaps;
}
  var get_orientation = function(input_cells) {
    var orientation; 
    var top_left_cell = find_top_left_tile_cell(input_cells);
    console.log('top-left:')
    console.log(top_left_cell);
    var bottom_right_cell = find_bottom_right_tile_cell(input_cells)
    console.log('bottom_right:')
    console.log(bottom_right_cell);
    if (top_left_cell.x == bottom_right_cell.x) { orientation = 'vertical' }
    if (top_left_cell.y == bottom_right_cell.y) { orientation = 'horizontal' }
    if (input_cells.length == 0) { orientation = 'one cell'}
    return orientation;
}
var get_cells_between_range = function(top_left_cell, bottom_right_cell, orientation) {
    var cells_in_range = [];
    if (orientation == 'vertical') {
        for (var i = top_left_cell.y; i <= bottom_right_cell.y; i++) {
            cells_in_range.push( new Cell($('.cell[data-y="'+i+'"][data-x="'+top_left_cell.x+'"]')) );
        }
    } else if (orientation == 'horizontal') {
        for (var i = top_left_cell.x; i <= bottom_right_cell.x; i++) {
            cells_in_range.push( new Cell($('.cell[data-x="'+i+'"][data-y="'+top_left_cell.y+'"]')) );
        }
    } else { cells_in_range.push(top_left_cell) }
    return cells_in_range;
};
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
var tile_exists_at = function(cell) {
    if (cell.children().length > 0) { return true }
    return false;
};

  var find_top_cell = function(input_cells) {
    var top_cell = input_cells[0];
    // look up from top cell
    var cell_above = $('.cell[data-y="'+(top_cell.y-1)+'"][data-x="'+top_cell.x+'"]');
    if (tile_exists_at(cell_above)) {
      while (tile_exists_at(cell_above)) {
        top_cell = new Cell(cell_above);
        cell_above = $('.cell[data-y="'+(top_cell.y-1)+'"][data-x="'+top_cell.x+'"]');
      }
    }
    return top_cell
  }

  var find_bottom_cell = function(input_cells) {
    var bottom_cell = input_cells[input_cells.length-1];
    // look down from bottom cell
    var cell_below = $('.cell[data-y="'+(bottom_cell.y+1)+'"][data-x="'+bottom_cell.x+'"]');
    if (tile_exists_at(cell_below)) {
      while (tile_exists_at(cell_below)) {
        bottom_cell = new Cell(cell_below);
        cell_below = $('.cell[data-y="'+(bottom_cell.y+1)+'"][data-x="'+bottom_cell.x+'"]');
      }
    }
    return bottom_cell
  }

  var find_left_cell = function(input_cells) {
    var left_cell = input_cells[0];
    // look left from left_cell
    var cell_left = $('.cell[data-x="'+(left_cell.x-1)+'"][data-y="'+left_cell.y+'"]');
    if (tile_exists_at(cell_left)) {
      console.log("Cell exists to left")
      while (tile_exists_at(cell_left)) {
        left_cell = new Cell(cell_left);
        cell_left = $('.cell[data-x="'+(left_cell.x-1)+'"][data-y="'+left_cell.y+'"]');
      }
    }
    return left_cell
  }

  var find_right_cell = function(input_cells) {
    var right_cell = input_cells[0];
    // look right from right_cell
    var cell_right = $('.cell[data-x="'+(right_cell.x+1)+'"][data-y="'+right_cell.y+'"]');
    if (tile_exists_at(cell_right)) {
        console.log("Cell exists to right")
        while (tile_exists_at(cell_right)) {
            right_cell = new Cell(cell_right)
            cell_right = $('.cell[data-x="'+(right_cell.x+1)+'"][data-y="'+right_cell.y+'"]');
        }
    }
    return right_cell
}

var chain_to_word = function(cell_chain) {
    var letter_arr = [];
    $.each(cell_chain,  function(i, cell) {
        letter_arr.push(cell.letter);
    })
    var word = letter_arr.join('')
    return word;
}

var tiles_spell_valid_word = function() {
    return true
};

// Get array of new_words formed by tiles
var get_cell_chains = function(input_cells) {
  var cell_chains = []
  if (input_cells.length == 1) {
    
  } else {
    var orientation = get_orientation(input_cells);
    input_cells = sort_input_cells(input_cells);
    if (orientation == 'vertical') {
      var top_cell = find_top_cell(input_cells);
      var bottom_cell = find_bottom_cell(input_cells);
      var main_chain = get_cells_between_range(top_cell, bottom_cell, orientation);
      cell_chains.push(main_chain);
      $.each(main_chain, function(index, cell) { // iterate through main chain
        var tile_exists_left = tile_exists_at($('.cell[data-x="'+(cell.x-1)+'"][data-y="'+cell.y+'"]'))
        var tile_exists_right = tile_exists_at($('.cell[data-x="'+(cell.x+1)+'"][data-y="'+cell.y+'"]'))
        var tile_is_recent = $('.cell[data-x="'+(cell.x)+'"][data-y="'+cell.y+'"]').find('div.tile').hasClass('ui-draggable')
        console.log(cell + " Tile is recent: " + tile_is_recent)
        if ( tile_is_recent && (tile_exists_left || tile_exists_right) ) { 
          var left_cell = find_left_cell([new Cell ($('.cell[data-x="'+(cell.x)+'"][data-y="'+cell.y+'"]'))])
          var right_cell = find_right_cell([new Cell ($('.cell[data-x="'+(cell.x)+'"][data-y="'+cell.y+'"]'))])
          var horizontal_chain = get_cells_between_range(left_cell, right_cell, 'horizontal');
          console.log(horizontal_chain)
          cell_chains.push(horizontal_chain);
        }      
      });
    } else if (orientation == 'horizontal') {
      var left_cell = find_left_cell(input_cells)
      var right_cell = find_right_cell(input_cells)
      var main_chain = get_cells_between_range(left_cell, right_cell, orientation)
      cell_chains.push(main_chain);
      $.each(main_chain, function(index, cell) { // iterate through main chain
        var tile_exists_above = tile_exists_at($('.cell[data-y="'+(cell.y-1)+'"][data-x="'+cell.x+'"]'))
        var tile_exists_below = tile_exists_at($('.cell[data-y="'+(cell.y+1)+'"][data-x="'+cell.x+'"]'))
        var tile_is_recent = $('.cell[data-x="'+(cell.x)+'"][data-y="'+cell.y+'"]').find('div.tile').hasClass('ui-draggable')
        console.log(cell + " Tile is recent: " + tile_is_recent)
        if ( tile_is_recent && (tile_exists_above || tile_exists_below) ) {
          var top_cell = find_top_cell([new Cell ($('.cell[data-y="'+(cell.y)+'"][data-x="'+cell.x+'"]'))])
          console.log(top_cell);
          var bottom_cell = find_bottom_cell([new Cell ($('.cell[data-y="'+(cell.y)+'"][data-x="'+cell.x+'"]'))])
          var vertical_chain = get_cells_between_range(top_cell, bottom_cell, 'vertical');
          console.log(vertical_chain)
          cell_chains.push(vertical_chain);
        }
      });
    }
  }
  return cell_chains
};

var find_new_tiles_on_board = function () {
    var input_cells = $('#board div.tile.ui-draggable');
    var tiles = [];
    for(var i = 0; i < input_cells.length; i++)
    {
        var tile = $(input_cells[i]);
        var cell = tile.parent();
        tiles.push({letter: tile.children().eq(1).html(), x: cell.data('x'), y: cell.data('y')})
    }
    return tiles;
};


// SubmitTurn event handler:
var on_turn_submit = function (f) { $('#submit_turn').on( 'click', f ) };
var validate_turn = function (e) {
  e.preventDefault();
  var input_cells = $('#board div.tile.ui-draggable').parent()
  if (tiles_are_inline(input_cells) && 
      tiles_touch_prev(input_cells) ) { 
    var words = [];
    var cell_chains = get_cell_chains(input_cells);
    $.each(cell_chains, function(i, chain) {
      console.log(chain);
      var word = chain_to_word(chain);
      console.log(word);
      words.push(word);
    })
    var parameterized_words = words.join('-');
   alert(parameterized_words);
    var game_id = $("#board").data("game_id");
    $.ajax({
        url: '/games/' + game_id + '/submit',
        type: 'POST',
        data: {tiles: find_new_tiles_on_board(), words: parameterized_words},
        dataType: 'json',
        success: function (status) {
            console.log(status);
            if (status == true)
            {
                window.location.reload(true);
            }
            else
            {
                alert("Invalid words: " + parameterized_words);
            }
        }
    });
  } else { 
    alert("Invalid Submission") 
  }
}

// runtime code
$(function(){
    on_turn_submit( validate_turn );

});
