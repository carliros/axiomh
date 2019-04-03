module Main where

import           ParserOptions
import           ParserInput(parseInput)
import           Text.Printf   (printf)

main :: IO ()
main = axioms =<< runParser

axioms :: AxiomOptions -> IO ()
axioms (AxiomOptions inputFile) = do
  putStrLn $ printf "Reading input '%s' ..." inputFile
  fileContent <- readFile inputFile
  let result = parseInput inputFile fileContent
  putStrLn "Print content ..."
  putStrLn $ show result
