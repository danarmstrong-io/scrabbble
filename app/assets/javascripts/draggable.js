// Instance variables
var current_tile;
var current_cell;

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
          console.log("you're dropping a cell");
          $(current_tile).css( {left: '0px', top: '0px'} );
          $(current_tile).detach().appendTo(this);
          $(this).droppable('disable');
        }
      });
    }
  });
};

var on_tile_grab = function(f) { $('.tile').on( 'mousedown', f ) };
var define_current_tile = function(e) {
  current_tile = $(this)[0];
  console.log($(current_tile).parent());
  $(current_tile).parent().droppable({
    drop: function() {
      console.log("you're dropping a cell");
      $(current_tile).css( {left: '0px', top: '0px'} );
      $(current_tile).detach().appendTo(this);
    }
  });
  $(current_tile).parent().droppable('enable');
};

$(function() {
  make_tray_tiles_draggable();
  make_cells_droppable();
  on_tile_grab( define_current_tile );
});
