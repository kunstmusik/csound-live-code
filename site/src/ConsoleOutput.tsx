import { useEffect, useRef } from "react";

export const ConsoleOutput = ({output}:{output:string}) => {
  const wrapperRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (wrapperRef.current) {
        wrapperRef.current.scrollTo(wrapperRef.current.scrollLeft, wrapperRef.current.scrollHeight);
    }
  }, [output])

  return (
    <div className="flex flex-col w-full h-full bg-bg-dark border-t border-border-dark">
      <div className="w-full px-4 py-1.5 bg-border-dark text-white font-sans text-sm font-bold select-none">
        Console
      </div>
      <div 
        ref={wrapperRef}
        className="flex-1 w-full p-5 overflow-auto bg-[#111111]"
      >
        <pre className="font-mono text-xs text-white whitespace-pre-wrap">{output}</pre>
      </div>
    </div>
  );
};

export default ConsoleOutput;
