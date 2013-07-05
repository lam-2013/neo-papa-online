/**
 * Created with JetBrains RubyMine.
 * User: mariateresa
 * Date: 05/07/13
 * Time: 21:10
 * To change this template use File | Settings | File Templates.
 */

function dragIt(target, e) {
    e.dataTransfer.setData('image/png', target.id);
}

function dragOver(e) {
    var postitv = e.dataTransfer.getData('image/png');
    var id = e.target.getAttribute('id');
    if (id =='postitv')
        return false;
    else
        return true;
}

function dropIt(target, e) {
    var id = e.dataTransfer.getData('image/png');
    target.appendChild(document.getElementById(id));
    e.preventDefault();
}
function trashIt(target, e) {
    var id = e.dataTransfer.getData('image/png');
    removeElement(id);
    e.preventDefault();
}
function removeElement(id)	{
    var d_node = document.getElementById(id);
    d_node.parentNode.removeChild(d_node);
}
