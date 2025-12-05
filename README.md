**Aplicação Delphi para Merge de PDFs** usando apenas componentes gratuitos:

### ✨ Recursos principais:

1. **Interface Visual Simples**:
   - Lista de PDFs com suporte para múltiplos arquivos
   - Botões para adicionar, remover e reorganizar PDFs
   - Log detalhado de todas as operações
   - Campo para configurar o caminho do PDFtk

2. **Funcionalidades**:
   - ✅ Adicionar múltiplos PDFs de uma vez
   - ✅ Remover PDFs da lista
   - ✅ Mover PDFs para cima/baixo (reorganizar ordem)
   - ✅ Fazer merge de todos os PDFs em um único arquivo
   - ✅ Detecção automática do PDFtk
   - ✅ Log completo de operações

3. **Tecnologia Usada**:
   - **PDFtk Server** (gratuito, GPL): ferramenta de linha de comando para manipular PDFs
   - Download: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

### 📦 Componentes utilizados:
- Apenas componentes nativos do Delphi VCL (100% gratuito)
- Nenhuma biblioteca de terceiros paga necessária

### 🚀 Como usar:

1. **Instalar o PDFtk**:
   - Baixe em: https://sourceforge.net/projects/pdftk-builder-enhanced/ 
   - Extrair o arquivo.
   - Basta apenas indicar o path do pdftk.exe

2. **Criar o projeto no Delphi**:
   - Compile e execute

3. **Usar a aplicação**:
   - Configure o PDFtk (se não for detectado automaticamente)
   - Adicione os PDFs
   - Reorganize se necessário
   - Clique em "FAZER MERGE"

A aplicação busca automaticamente o PDFtk em locais comuns de instalação e permite 
configuração manual se necessário. O log mostra todas as operações para 
facilitar o debug.