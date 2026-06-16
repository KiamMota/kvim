local M = {}


local function abbrev(wrongs, correct)
  for _, wrong in ipairs(wrongs) do
    vim.cmd('iabbrev ' .. wrong .. ' ' .. correct)
  end
end
abbrev({'funciton', 'funtion', 'fnc', 'fnution'}, 'function')
abbrev({'retunr', 'retrun', 'retun'}, 'return')
abbrev({'flase', 'fals'}, 'false')
abbrev({'ture', 'treu'}, 'true')
abbrev({'tehn', 'thean'}, 'then')
abbrev({'esle', 'els'}, 'else')
abbrev({'cosnt', 'constante'}, 'const')
abbrev({'improt', 'improts'}, 'import')

abbrev({'lenght', 'lenth', 'lenght'}, 'length')

abbrev({'stirng', 'strnig'}, 'string')
abbrev({'numebr', 'numbe'}, 'number')
abbrev({'obect', 'obet', 'ojbect'}, 'object')
abbrev({'bollean', 'boolen'}, 'boolean')
abbrev({'exprots', 'exprot'}, 'export')

abbrev({'braek', 'brek'}, 'break')
abbrev({'contineu', 'contniue'}, 'continue')
abbrev({'switc', 'swithc'}, 'switch')
abbrev({'defualt', 'defulat'}, 'default')

abbrev({'asnyc', 'asny'}, 'async')
abbrev({'awiated', 'awaitng', 'awiart'}, 'await')

abbrev({'clasa', 'clss'}, 'class')
abbrev({'pacakge', 'packge'}, 'package')
abbrev({'moudle', 'moduel'}, 'module')

abbrev({'cahtc', 'catche'}, 'catch')
abbrev({'enviroment', 'enviornment'}, 'environment') -- O 'n' silencioso é sempre esquecido
abbrev({'initital', 'intial'}, 'initial')
abbrev({'configruation', 'configruare'}, 'configuration')
abbrev({'requset', 'reqeust'}, 'request')
abbrev({'repsone', 'responce'}, 'response')
abbrev({'paramters', 'params'}, 'parameters')
abbrev({'witdh', 'widh'}, 'width')
abbrev({'heigth', 'heigt'}, 'height')

abbrev({'arrow', 'arrf'}, '=>')

abbrev({'to'}, '->')

abbrev({'todo'}, '// TODO:')
abbrev({'fixme'}, '// FIXME:')

abbrev({'clog'}, 'console.log()')
abbrev({'vprint'}, 'print(f"")')

abbrev({'req'}, 'require("")')

return M
