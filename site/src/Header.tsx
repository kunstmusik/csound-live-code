import { HStack, IconButton, Spacer } from "@chakra-ui/react";
import { CsoundObj } from "@csound/browser";

import { FaPauseCircle, FaQuestionCircle, FaRedoAlt } from "react-icons/fa";

const Header = ({csound}:{csound:CsoundObj}) => {
   return     <HStack w="100%" p="2" backgroundColor="#272822" borderBottom="1px solid gray">
   <h1>csound-live-code</h1>
   <IconButton aria-label="Pause Engine" icon={<FaPauseCircle/>} fontSize="24px"/>
   <IconButton aria-label="Reestart Engine" icon={<FaRedoAlt/>} fontSize="24px"/>
   <Spacer/>
   
   <IconButton aria-label="Open Documentation in new Window" icon={<FaQuestionCircle/>} fontSize="24px"/>
 </HStack>
}

export default Header;