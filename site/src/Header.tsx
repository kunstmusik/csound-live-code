import { HStack, IconButton, Spacer } from "@chakra-ui/react";
import { CsoundObj } from "@csound/browser";

import { FaPauseCircle, FaQuestionCircle, FaRedoAlt } from "react-icons/fa";

const Header = ({csound}:{csound:CsoundObj}) => {
   return     <HStack w="100%" p="0.5em 1em"  backgroundColor="#272822" borderBottom="1px solid #333333">
   <h1>csound-live-code</h1>
   <IconButton aria-label="Pause Engine" icon={<FaPauseCircle/>} fontSize="22px" size="sm"/>
   <IconButton aria-label="Reestart Engine" icon={<FaRedoAlt/>} fontSize="22px" size="sm"/>
   <Spacer/>
   
   <IconButton aria-label="Open Documentation in new Window" icon={<FaQuestionCircle/>} fontSize="22px" size="sm"/>
 </HStack>
}

export default Header;