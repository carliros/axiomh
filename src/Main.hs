module Main where

import Text.Printf (printf)
import ParserOptions

main :: IO ()
main = axioms =<< runParser

axioms :: AxiomOptions -> IO()
axioms (AxiomOptions inputFile)
  = do putStrLn $ printf "Reading input '%s' ..." inputFile
       fileContent <- readFile inputFile
       putStrLn "Print content ..."
       putStrLn fileContent
