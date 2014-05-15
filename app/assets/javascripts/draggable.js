// Instance variables
var current_tile;
var current_cell;

var make_tray_tiles_draggable = function() {
  return $('#tray .tile').draggable({
    snap: '.cell',
    revert: 'valid' });
};

var make_cells_droppable = function() {
  $('.cell').droppable({
    drop: function() {
      if ($(this).children().length == 0) {
        current_tile.css( {left: '0px', top: '0px'} );
        current_tile.detach().appendTo(this); } }
  });
};

var on_tile_grab = function(f) { $('.tile').on( 'mousedown', f ) };
var define_current_tile = function(e) { current_tile = $(this) };

$(function() {
  make_tray_tiles_draggable();
  make_cells_droppable();
  on_tile_grab( define_current_tile );
});
