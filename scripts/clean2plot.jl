## Julia script to clean the raw data
## and plot the word cloud
## Claudia January 2021

using DrWatson
@quickactivate

using CSV, DataFrames
using Arrow, Tables

## raw data: not publicly available due to student's names
f = CSV.File("data/poll-csv/2-what-tools-have-you-used-all-lower-case.csv")
ct = Tables.columntable(f)
df = DataFrame(ct)

## we want to first convert multi-responses to multiple columns
response = reduce(vcat, vec)

## lowercase all
response = lowercase.(response)

## remove the commas
response = replace.(response, ','=>"")

## manual fix of mismatches
response = replace.(response, "paup*"=>"paup")
response = replace.(response, "iqtree"=>"iq-tree")
response = replace.(response, "mr."=>"mrbayes")
response = response[response.!="i"]
response = response[response.!="don't"]
response = response[response.!="remember."]
response = response[response.!="packages"]
response = response[response.!="na"]
response = response[response.!="bayes"]

## save as cleaned data
df2 = DataFrame(response=response)
CSV.write("data/clean-data.csv",df2)


