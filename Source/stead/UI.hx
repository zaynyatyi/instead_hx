package stead;
import js.html.Element;
import js.Browser;

/**
 * ...
 * @author gordev
 */
class UI
{
    public var saveButton:Element;
    public var loadButton:Element;
    
    public function new() 
    {
        saveButton = Browser.document.getElementById('save');
        loadButton = Browser.document.getElementById('load');
    }
    
}