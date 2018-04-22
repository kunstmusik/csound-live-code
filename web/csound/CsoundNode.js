/*
 * C S O U N D
 *
 * L I C E N S E
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 */

class CsoundNode extends AudioWorkletNode {

  constructor(context, options) {
    options = options || {};
    options.numberOfInputs  = 1;
    options.numberOfOutputs = 2;
    options.channelCount = 2;

    super(context, 'Csound', options);

    this.port.start();
  }


  static importScripts(actx) {
    return new Promise( (resolve) => {
      actx.audioWorklet.addModule('libcsound.base64.js').then(() => {
      actx.audioWorklet.addModule('libcsound.js').then(() => {
      actx.audioWorklet.addModule('CsoundProcessor.js').then(() => {
        resolve(); 
      }) }) })      
    }) 
  }

}

