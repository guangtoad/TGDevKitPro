
import { hvigor, HvigorNode, HvigorPlugin } from '@ohos/hvigor';
import { OhosHapContext, OhosHarContext, OhosHspContext, OhosPluginId } from '@ohos/hvigor-ohos-plugin';

import { logger } from "./utils/TGLoger";
export class TGHMPluginMgr {
    executePlugin(node: HvigorNode, pluginId: string) {
        logger('TGHMPluginMgr', 'executePlugin begin');
        // Get the node context
        const moduleContext = node.getContext(pluginId) as OhosHapContext | OhosHarContext | OhosHspContext;
        const moduleName = moduleContext.getModuleName();

    }
}