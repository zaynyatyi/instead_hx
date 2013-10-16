package;

import stead.SteadDispatcher;

class Main {
	
    private var stead_dispatcher:SteadDispatcher;

	public function new () {
        stead_dispatcher = new SteadDispatcher();
	}
	
    static function main() {
        var object:Main = new Main();
    }
}
