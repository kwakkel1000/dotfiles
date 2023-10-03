local llamacpp = require('llm.providers.llamacpp')
local util = require('llm.util')
local llm = require('llm')

local builder = function(input)
    return {
        prompt = llamacpp.llama_2_format({
            messages = {
                input
            }
        })
    }
end

local options = {
    path = "/home/gijsk/llama.cpp/",
    main_dir = "",
    --      path = os.getenv('LLAMACPP_DIR'),
    --      main_dir = os.getenv('LLAMACPP_MAIN_DIR')
}

local params = {
    --['n-gpu-layers'] = 32,
    threads = 7,
    ['repeat-penalty'] = 1.2,
    temp = 0.2,
    ['ctx-size'] = 2048,
    --['ctx-size'] = 4096,
    ['n-predict'] = 200,
    --['n-predict'] = -1,
}

local prompt = {
    provider = llamacpp,
    params = params,
    builder = builder,
    options = options
}


local default_prompt = vim.deepcopy(prompt)

default_prompt.params.model = 'models/open_llama_7b/ggml-model-f16.bin'

local code_prompt = vim.deepcopy(prompt)
code_prompt.params.model = 'models/Wizard-Vicuna-13B-Uncensored.ggmlv3.q5_0.bin'
code_prompt.params.temp = 0.11
code_prompt.params['n-predict'] = 500
code_prompt.builder = function(input, context)
    local question =
        "### Instruction: Replace the token <@@> with valid code. Respond only with code, never respond with an explanation, never respond with a markdown code block containing the code. Generate only code that is meant to replace the token, do not regenerate code in the context. " ..
        input .. "\n### Response:"
    --print(question)
    return {
        --prompt = llamacpp.llama_2_format({
        --    messages = {
        --        input
        --    },
        --    system =
        --    [["Replace the token <@@> with valid code. Respond only with code, never respond with an explanation, never respond with a markdown code block containing the code. Generate only code that is meant to replace the token, do not regenerate code in the context."]]
        --})
        prompt = question

    }
end
code_prompt.mode = llm.mode.INSERT_OR_REPLACE



local code2_prompt = vim.deepcopy(prompt)
code2_prompt.params.model = 'models/wizard-mega-13B.ggmlv3.q5_1.bin'
code2_prompt.params.temp = 0.05
code2_prompt.params['n-predict'] = 2500
code2_prompt.builder = function(input, context)
    local lines_before = 50
    local lines_after = 50

    local text_before = util.string.join_lines(util.table.slice(context.before, -lines_before))
    local text_after = util.string.join_lines(util.table.slice(context.after, 0, lines_after))
    local content = 'The code:\n```\n' .. text_before .. '<@@>' .. text_after .. '\n```\n'

    local instruction =
    "Replace the token <@@> with valid code. Respond only with code, never respond with an explanation, never respond with a markdown code block containing the code. Generate only code that is meant to replace the token, do not regenerate code in the context."
    local local_prompt =
        "### Instruction: "
        .. instruction .. "\n"
        .. input .. "\n"
        .. content
        .. "\n\n### Assistant:\n"
    return {
        prompt = local_prompt
    }
end
code2_prompt.mode = llm.mode.INSERT_OR_REPLACE
--### Instruction: write Python code that returns the first n numbers of the Fibonacci sequence using memoization.
--
--### Assistant:
--```python
--def fib(n):
--    if n < 2:
--        return n
--    elif n in cache:
--        return cache[n]
--    else:
--        a, b = 0, 1
--        for i in range(2, n+1):
--            cache[i] = a
--            a, b = b, a + b
--        return cache[n]
--
--def first_n(n):
--    fib_list = [fib(i) for i in range(n+1)]
--    return fib_list[:n]
--```
--This function uses memoization to store the values of previous Fibonacci numbers in a cache. This way, if the same number is requested again, it can be returned immediately without recalculating it.
--The `first_n` function takes an integer `n` as input, and calculates the first n numbers of the Fibonacci sequence using memoization. It returns a list of those numbers.



local prompt_library = {
    default = default_prompt,
    code = code_prompt,
    code2 = code2_prompt
}

--print(vim.inspect(prompt_library))

require('llm').setup({
    hl_group = 'Substitute',
    prompts = prompt_library,
    --prompts = util.module.autoload('prompt_library'),
    default_prompt = prompt_library.default
})


--return prompt_library
