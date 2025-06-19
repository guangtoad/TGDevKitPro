
import { hvigor, HvigorNode, HvigorPlugin } from '@ohos/hvigor';
import { hapTasks, OhosHapContext, OhosPluginId, Target, Product, OhosAppContext } from '@ohos/hvigor-ohos-plugin';
import { tgDependencyPluginConfig } from "./TGHMPluginConfig";
import { logger } from "./utils/TGLoger";
import  TGHMPluginConstant  from "./constants/CommonConstants";
import { TGHMPluginMgr  } from "./TGHMPluginMgr";
import { Hash } from 'crypto';
let TGHMPluginMgrInstance: TGHMPluginMgr | null = null;

export function tgAppPlugin(config:tgDependencyPluginConfig): HvigorPlugin {
  return {
    pluginId: TGHMPluginConstant.APP_PLUGIN_ID,
    apply(node: HvigorNode) {
      logger('apply', 'hello AppPlugin!');
      if (!TGHMPluginMgrInstance) {
        TGHMPluginMgrInstance = new TGHMPluginMgr();
      }
      TGHMPluginMgrInstance.executePlugin(node, OhosPluginId.OHOS_APP_PLUGIN);
    }
  }
}


export function tgHarPlugin(config:tgDependencyPluginConfig): HvigorPlugin {
  return {
    pluginId: TGHMPluginConstant.HAR_PLUGIN_ID,
    apply(node: HvigorNode) {
      logger('apply', 'hello HarPlugin!');
      if (!TGHMPluginMgrInstance) {
        TGHMPluginMgrInstance = new TGHMPluginMgr();
      }
      TGHMPluginMgrInstance.executePlugin(node, OhosPluginId.OHOS_HAR_PLUGIN); 
    }
  }
}
export function tgHspPlugin(config:tgDependencyPluginConfig): HvigorPlugin {
  return {
    pluginId: TGHMPluginConstant.HSP_PLUGIN_ID,
    apply(node: HvigorNode) {
      logger('apply', 'hello HspPlugin!');
      if (!TGHMPluginMgrInstance) {
        TGHMPluginMgrInstance = new TGHMPluginMgr();
      }
      TGHMPluginMgrInstance.executePlugin(node, OhosPluginId.OHOS_HSP_PLUGIN); 
   
    }
  }
}

export function tgDependencyPlugin(config:tgDependencyPluginConfig): HvigorPlugin {
  return {
    pluginId: "tgHMPlugin",
    apply(node: HvigorNode) {
      
      const nodeContext = node.getContext(OhosPluginId.OHOS_HAP_PLUGIN) as OhosHapContext;

      const moduleJsonOpt = nodeContext.getModuleJsonOpt();
      moduleJsonOpt.module
      nodeContext?.targets((target: Target) => {
        const dependency = nodeContext.getDependenciesOpt();
        
      });
        
      nodeContext.setModuleJsonOpt(moduleJsonOpt);
      // LogConfig.init(config)
      logger('apply', 'hello routerRegisterPlugin!');
      // logger('apply', PLUGIN_ID)
      logger('apply', `dirname: ${__dirname} `)
      logger('apply cwd: ', process.cwd()) // 应用项目的根目录
      logger('apply nodeName: ', node.getNodeName()) //模块名 ，比如entry，harA
      logger('apply nodePath: ', node.getNodePath()) //模块路径  这里和nodeDir是一样的
      // initConfig(config, node);
      // executePlugin(config, node)
    }
  }
}