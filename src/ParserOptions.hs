module ParserOptions (
  AxiomOptions(..)
, runParser
) where

import Options.Applicative
import Data.Semigroup ((<>))

data AxiomOptions
  = AxiomOptions { input :: FilePath }

parseOptions :: Parser AxiomOptions
parseOptions = AxiomOptions <$> argument str
  ( metavar "FILE" <> help "Input file for the app"
  )

runParser = execParser opts
 where
  opts = info
    (parseOptions <**> helper)
    ( fullDesc <> progDesc "Axioms prover helper" <> header
      "ahc - helps to prove axioms"
    )
