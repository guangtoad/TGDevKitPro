import { logger}  from "./src/utils/TGLoger";
import { tgDependencyPlugin,tgAppPlugin} from "./src/TGHMHvigorPlugin";
import { tgDependencyPluginConfig } from "./src/TGHMPluginConfig";
import { hvigor, HvigorNode, HvigorPlugin } from '@ohos/hvigor';

class TestNode {

    getContext(pluginId: string){
        return this;
    };
    getModuleName(){
        return "name";
    }
}

function main(){
    try {
        let node = new TestNode();
        tgAppPlugin({modules: {
            
        }} as tgDependencyPluginConfig).apply(node as HvigorNode) ;
        // tgHMPlugin.apply(node as HvigorNode) ;
    } catch (error) {
        logger("main","catch" + error);
    }
    finally{
        logger("finally");
    }
}
main();