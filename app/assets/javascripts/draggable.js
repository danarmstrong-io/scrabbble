// Local variables
var current_tile;
var current_cell;

// Apply Jquery UI's draggable/droppable behavior to cells and tiles.
var make_tray_tiles_draggable = function() {
  return $('#tray .tile').draggable({
    revert: 'invalid' });
};
var make_cells_droppable = function() {
  var cells = $('td.cell');
  $.each(cells, function(index, cell) {
    if ($(cell).children().length == 0) {
      $(cell).droppable({
        drop: function() {
          $(current_tile).css( {left: '0px', top: '0px'} );
          $(current_tile).detach().appendTo(this);
          $(this).droppable('disable');
        }
      });
      $(this).droppable('enable');
    }
  });
};

// Listener and callback to Update DOM based on user Dragging/Dropping
var on_tile_grab = function(f) { $('.tile').on( 'mousedown', f ) };
var define_current_tile = function(e) {
  current_tile = $(this)[0];
  $(current_tile).parent().droppable({
    drop: function() {
      $(current_tile).css( {left: '0px', top: '0px'} );
      $(current_tile).detach().appendTo(this);
    }
  });
  $(current_tile).parent().droppable('enable');
};

// SHUFFLE LETTERS - TO BE BUILT LATER
// var on_click_shuffle = function(f) {$("#shuffle").on("click", f)};
// var shuffle_tiles = function(e) {
//   e.preventDefault();
// }

// RESET LETTERS
var on_click_reset = function(f) {$("#reset").on("click", f)};
var reset_tray = function(e) {
  e.preventDefault();
  var unplaced_tiles = $('div.tile.ui-draggable');
  var tray_cells = $("#tray tr").children();
  $.each(unplaced_tiles, function(index, tile) {
    var cell = tray_cells[index];
    $(tile).detach().appendTo($(cell));
  });
  make_cells_droppable();
}

// Runtime Code
$(function() {
  make_tray_tiles_draggable();
  make_cells_droppable();
  on_tile_grab( define_current_tile );
  // on_click_shuffle( shuffle_tiles );
  on_click_reset( reset_tray );
});
