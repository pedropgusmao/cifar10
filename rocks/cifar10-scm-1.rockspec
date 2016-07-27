package = "cifar10"
version = "scm-1"

source = {
	url = "git://github.com/pedropgusmao/cifar10.git"
}

description = {
	summary = "CIFAR-10 Dataset",
	detailed = [[
		    ]],
	homepage = "https://github.com/pedropgusmao/cifar10",
	license = "BSD"
} 

dependencies = {
	"torch >= 7.0",
	"paths >= 1.0",
}
			
build = {
	type = "builtin",
	modules = {
		["cifar10.init"] = "init.lua"
	},

	install = {
		lua = {
			["cifar10.data.data_batch_1.bin"] = "data/data_batch_1.bin",
			["cifar10.data.data_batch_2.bin"] = "data/data_batch_2.bin",
			["cifar10.data.data_batch_3.bin"] = "data/data_batch_3.bin",
			["cifar10.data.data_batch_4.bin"] = "data/data_batch_4.bin",
			["cifar10.data.data_batch_5.bin"] = "data/data_batch_5.bin",
			["cifar10.data.test_batch.bin"] = "data/test_batch.bin",
		}
	}
}
