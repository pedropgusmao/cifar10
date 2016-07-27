local torch = require 'torch'
require 'paths'

local cifar10 = {}

local function createdataset(inputFnames, outputFname)
	local nSamples = 0
	for i=1,#inputFnames do
		local inputFname = inputFnames[i]
		local m=torch.DiskFile(inputFname, 'r'):binary()
		m:seekEnd()
		local length = m:position() - 1
		local nSamplesF = length / 3073 -- 1 label byte, 3072 pixel bytes
		assert(nSamplesF == math.floor(nSamplesF), 'expecting numSamples to be an exact integer')
		nSamples = nSamples + nSamplesF
		m:close()
	end

	local label = torch.ByteTensor(nSamples)
	local data = torch.ByteTensor(nSamples, 3, 32, 32)

	local index = 1
	for i=1,#inputFnames do
		local inputFname = inputFnames[i]
		local m=torch.DiskFile(inputFname, 'r'):binary()
		m:seekEnd()
		local length = m:position() - 1
		local nSamplesF = length / 3073 -- 1 label byte, 3072 pixel bytes
		m:seek(1)
		for j=1,nSamplesF do
			label[index] = m:readByte()
			local store = m:readByte(3072)
			data[index]:copy(torch.ByteTensor(store))
			index = index + 1
		end
		m:close()
	end

	local out = {}
	out.data = data
	out.label = label
	out.size  = data:size(1)
	torch.save(outputFname, out)
end

local function loaddataset(filename)
	local dataset = torch.load(filename)
	assert(dataset.data:size(1) == dataset.label:size(1))
	setmetatable(dataset, {__index=function(self, idx)
		assert(idx > 0 and idx <= self.size)
		return {x=data[idx], y=label[idx]}
	end})
	return dataset
end

function cifar10.traindataset()
	local path 	   = paths.dirname( paths.thisfile() )
	local trainfile = paths.concat(path, "cifar10-train.t7")
	if not paths.exists(path, trainfile) then
		createdataset({paths.concat(path, 'data/data_batch_1.bin'),
		paths.concat(path, 'data/data_batch_2.bin'),
		paths.concat(path, 'data/data_batch_3.bin'),
		paths.concat(path, 'data/data_batch_4.bin'),
		paths.concat(path, 'data/data_batch_5.bin')}, trainfile)
	end
	return loaddataset(trainfile)
end

function cifar10.testdataset()
	local path 	   = paths.dirname( paths.thisfile() )
	local testfile  = paths.concat(path, "cifar10-test.t7")
	if not paths.exists(path, testfile) then 
		createdataset({paths.concat(path, 'data/test_batch.bin')}, testfile)
	end
	return loaddataset(testfile)

end

return cifar10
