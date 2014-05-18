//var on_turn_submit = function (f) { $('#submit_turn').on( 'click', f ) };
//var find_new_tiles_on_board = function (e) {
//    e.preventDefault();
//    var input_cells = $('#board div.tile.ui-draggable');
//    var tiles = [];
//    for(var i = 0; i < input_cells.length; i++)
//    {
//        var tile = $(input_cells[i]);
//        var cell = tile.parent();
//        tiles.push({letter: tile.children().eq(1).html(), x: cell.data('x'), y: cell.data('y')})
//    }
//
//
//
//};
//
//$(function(){
//    on_turn_submit( find_new_tiles_on_board );
//});