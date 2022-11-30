import { Box, VStack } from "@chakra-ui/react";
import { useEffect } from "react";

export const ConsoleOutput = ({output}:{output:string}) => {

  useEffect(() => {
    const wrapper = document.querySelector("#consoleWrapper")!;

    // if(wrapper.scrollHeight - wrapper.scrollTop < 20) {
        wrapper.scrollTo(wrapper.scrollLeft, wrapper.scrollHeight);
    // }
  }, [output])

  return (
    <VStack w="full" h="300px" minH="300px">
      <Box className="headerTab" w="full">Console</Box>
      <Box id="consoleWrapper" overflow="auto" w="full" p="5">
        <pre id="consoleOutput">${output}</pre>
      </Box>
    </VStack>
  );
};

export default ConsoleOutput;
