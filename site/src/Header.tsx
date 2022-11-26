import {
  Button,
  HStack,
  IconButton,
  Input,
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalFooter,
  ModalHeader,
  ModalOverlay,
  Spacer,
  Text,
  useDisclosure,
  VStack,
} from "@chakra-ui/react";
import { CsoundObj } from "@csound/browser";
import { ReactCodeMirrorRef } from "@uiw/react-codemirror";
import { MutableRefObject, useEffect, useState } from "react";

import {
  FaDownload,
  FaPauseCircle,
  FaPlayCircle,
  FaQuestionCircle,
  FaRedoAlt,
} from "react-icons/fa";
import { openHelp, restartCsound, saveDocument } from "./actions";

const d = new Date();
const dateHeader = `${d.getFullYear()}-${d.getMonth()}-${d.getDay()}`;

const Header = ({
  csound,
  code,
}: {
  csound: CsoundObj;
  code: string;
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
      <IconButton
        aria-label="Restart Engine"
        icon={<FaRedoAlt />}
        fontSize="22px"
        size="sm"
        onClick={() => {
          restartCsound(csound);
        }}
      />
      <IconButton
        aria-label="Download ORC"
        icon={<FaDownload />}
        fontSize="22px"
        size="sm"
        onClick={onOpen}
      />
      <Spacer />

      <IconButton
        aria-label="Open Documentation in new Window"
        icon={<FaQuestionCircle />}
        fontSize="22px"
        size="sm"
        onClick={openHelp}
      />

      <Modal isOpen={isOpen} onClose={onClose}>
        <ModalOverlay />
        <ModalContent backgroundColor="#222222">
          <ModalHeader>Save File</ModalHeader>
          <ModalCloseButton />
          <ModalBody >
            <VStack>
              <Text>Name of file</Text>
              <Input w="full" value={filename} onChange={(evt) => setFilename(evt.target.value)}/>
            </VStack>
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
