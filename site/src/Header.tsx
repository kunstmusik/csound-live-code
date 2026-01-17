import { CsoundObj } from "@csound/browser";
import { useEffect, useState } from "react";
import screenfull from "screenfull";
import * as Tooltip from "@radix-ui/react-tooltip";

import {
  FaDownload,
  FaExpand,
  FaPauseCircle,
  FaPlayCircle,
  FaQuestionCircle,
  FaRedoAlt,
  FaTerminal,
} from "react-icons/fa";
import { openHelp, restartCsound, saveDocument } from "./actions";

const d = new Date();
const dateHeader = `${d.getFullYear()}-${d.getMonth()}-${d.getDay()}`;

const TooltipButton = ({ onClick, icon, label }: { onClick: () => void; icon: React.ReactNode; label: string }) => (
  <Tooltip.Provider delayDuration={0}>
    <Tooltip.Root>
      <Tooltip.Trigger asChild>
        <button
          onClick={onClick}
          className="p-1.5 text-xl text-gray-300 transition-colors bg-transparent rounded hover:text-blue-100 hover:bg-white/10 outline-none focus:ring-2 focus:ring-blue-500/50"
        >
          {icon}
        </button>
      </Tooltip.Trigger>
      <Tooltip.Portal>
        <Tooltip.Content
          className="px-2 py-1 text-xs text-white bg-black rounded shadow-md select-none animate-in fade-in-0 zoom-in-95 data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=closed]:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=top]:slide-in-from-bottom-2"
          sideOffset={5}
        >
          {label}
          <Tooltip.Arrow className="fill-black" />
        </Tooltip.Content>
      </Tooltip.Portal>
    </Tooltip.Root>
  </Tooltip.Provider>
);

const Header = ({
  csound,
  code,
  showConsole,
  setShowConsole,
}: {
  csound: CsoundObj;
  code: string;
  showConsole: boolean;
  setShowConsole: React.Dispatch<React.SetStateAction<boolean>>;
}) => {
  const [running, setRunning] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [filename, setFilename] = useState(`${dateHeader}_project.orc`);

  useEffect(() => {
    csound.addListener("play", () => {
      setRunning(true);
    });

    csound.addListener("pause", () => {
      setRunning(false);
    });

    csound.addListener("stop", () => {
      setRunning(false);
    });
  }, [csound]);

  const onOpen = () => setIsModalOpen(true);
  const onClose = () => setIsModalOpen(false);

  return (
    <>

      <div className="flex items-center w-full p-4 bg-bg-dark border-b border-border-dark text-text-main h-10">
        <h1 className="text-sm font-bold font-sans mr-3 select-none">csound-live-code</h1>
        
        <div className="flex items-center gap-2">
          <TooltipButton
            label={running ? "Pause Engine" : "Play Engine"}
            icon={running ? <FaPauseCircle /> : <FaPlayCircle />}
            onClick={async () => {
              if (running) {
                await csound.pause();
              } else {
                await csound.resume();
              }
            }}
          />

          <TooltipButton
            label="Restart Engine"
            icon={<FaRedoAlt />}
            onClick={() => restartCsound(csound)}
          />

          <TooltipButton
            label="Download ORC"
            icon={<FaDownload />}
            onClick={onOpen}
          />

          <TooltipButton
            label="Toggle Console"
            icon={<FaTerminal />}
            onClick={() => setShowConsole(!showConsole)}
          />

          {screenfull.isEnabled && (
            <TooltipButton
              label="Toggle Fullscreen"
              icon={<FaExpand />}
              onClick={() => {
                if (screenfull.isFullscreen) {
                  screenfull.exit();
                } else {
                  screenfull.request();
                }
              }}
            />
          )}
        </div>

        <div className="flex-grow" />

        <TooltipButton
          label="Open Documentation"
          icon={<FaQuestionCircle />}
          onClick={openHelp}
        />
      </div>

      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">
          <div className="w-full max-w-md p-6 bg-modal-bg rounded-lg shadow-xl text-white border border-border-dark">
            <h2 className="text-xl font-bold mb-4 font-sans">Save File</h2>
            
            <div className="mb-6">
              <label className="block text-sm font-medium mb-2">Name of file</label>
              <div className="flex">
                <span className="inline-flex items-center px-3 rounded-l-md border border-r-0 border-gray-600 bg-gray-700 text-gray-300 text-sm">
                  Name of file
                </span>
                <input
                  type="text"
                  className="flex-1 block w-full rounded-none rounded-r-md bg-gray-600 border-gray-600 sm:text-sm p-2.5 focus:ring-blue-500 focus:border-blue-500"
                  value={filename}
                  onChange={(evt) => setFilename(evt.target.value)}
                />
              </div>
            </div>

            <div className="flex justify-end gap-3">
              <button
                onClick={onClose}
                className="px-4 py-2 text-sm font-medium text-gray-300 bg-transparent hover:bg-white/5 rounded-md transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={() => {
                  saveDocument(filename, code);
                  onClose();
                }}
                className="px-4 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-md transition-colors"
              >
                Save
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default Header;
