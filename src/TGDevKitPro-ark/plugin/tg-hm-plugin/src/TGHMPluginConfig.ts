import { Hash } from "crypto";

export interface tgDependencie {
    path?:string;
    request:boolean;
}

export interface tgDependencies extends Map<string,tgDependencie> {
}

export interface tgDodule extends Map<string,tgDependencie> {
}

export interface tgModules extends Map<string,tgDodule> {
}

export interface tgDependencyPluginConfig  {
    modules?:tgModules;
    dependencys?: tgDependencies;
}