module Main where

import           ParserOptions
import           Text.Printf   (printf)

main :: IO ()
main = axioms =<< runParser

axioms :: AxiomOptions -> IO ()
axioms (AxiomOptions inputFile) = do
  putStrLn $ printf "Reading input '%s' ..." inputFile
  fileContent <- readFile inputFile
  putStrLn "Print content ..."
  putStrLn fileContent
