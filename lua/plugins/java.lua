return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java"
  },
  {
    "JavaHello/spring-boot.nvim",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
      "ibhagwan/fzf-lua",        -- 可选
    },
    opts = {}
  }
}
