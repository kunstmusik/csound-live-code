import {
  Button,
  HStack,
  IconButton,
  Input,
  InputGroup,
  InputLeftAddon,
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalFooter,
  ModalHeader,
  ModalOverlay,
  Spacer,
  Tooltip,
  useDisclosure,
} from "@chakra-ui/react";
import { CsoundObj } from "@csound/browser";
import { useEffect, useState } from "react";
import screenfull from "screenfull";

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
  const { isOpen, onOpen, onClose } = useDisclosure();
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

  return (
    <HStack
      w="100%"
      p="0.5em 1em"
      backgroundColor="#272822"
      borderBottom="1px solid #333333"
    >
      <h1>csound-live-code</h1>
      <Tooltip hasArrow label={running ? "Pause Engine" : "Play Engine"}>
        <IconButton
          aria-label="Pause Engine"
          icon={running ? <FaPauseCircle /> : <FaPlayCircle />}
          fontSize="22px"
          size="sm"
          onClick={async () => {
            if (running) {
              await csound.pause();
            } else {
              await csound.resume();
            }
          }}
        />
      </Tooltip>

      <Tooltip hasArrow label={"Restart Engine"}>
        <IconButton
          aria-label="Restart Engine"
          icon={<FaRedoAlt />}
          fontSize="22px"
          size="sm"
          onClick={() => {
            restartCsound(csound);
          }}
        />
      </Tooltip>

      <Tooltip hasArrow label={"Download ORC"}>
        <IconButton
          aria-label="Download ORC"
          icon={<FaDownload />}
          fontSize="22px"
          size="sm"
          onClick={onOpen}
        />
      </Tooltip>

      <Tooltip hasArrow label={"Toggle Console"}>
        <IconButton
          aria-label="Toggle Console"
          icon={<FaTerminal />}
          fontSize="22px"
          size="sm"
          onClick={() => {setShowConsole(!showConsole)}}
        />
      </Tooltip>
      {screenfull.isEnabled && (
        <Tooltip hasArrow label={"Toggle Fullscreen"}>
          <IconButton
            aria-label="Toggle Fullscreen"
            icon={<FaExpand />}
            fontSize="22px"
            size="sm"
            onClick={() => {
              if (screenfull.isFullscreen) {
                screenfull.exit();
              } else {
                screenfull.request();
              }
            }}
          />
        </Tooltip>
      )}
      <Spacer />

      <Tooltip hasArrow label={"Open Documentation"}>
        <IconButton
          aria-label="Open Documentation in new Window"
          icon={<FaQuestionCircle />}
          fontSize="22px"
          size="sm"
          onClick={openHelp}
        />
      </Tooltip>

      <Modal isOpen={isOpen} onClose={onClose}>
        <ModalOverlay />
        <ModalContent backgroundColor="#222222">
          <ModalHeader>Save File</ModalHeader>
          <ModalCloseButton />
          <ModalBody>
            <InputGroup>
              <InputLeftAddon>Name of file</InputLeftAddon>
              <Input
                w="full"
                value={filename}
                onChange={(evt) => setFilename(evt.target.value)}
              />
            </InputGroup>
          </ModalBody>

          <ModalFooter>
            <Button
              colorScheme="blue"
              mr={3}
              onClick={() => {
                saveDocument(filename, code);
                onClose();
              }}
            >
              Save
            </Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </HStack>
  );
};

export default Header;
