# teste
$configFile = "C:\Users\Prefa\AppData\Roaming\MicroSIP\MicroSIP.ini"

# Caminho para o executável do MicroSIP
$microSIPPath = "C:\Users\Prefa\AppData\Local\MicroSIP\microsip.exe"

# Função para verificar o status do DND
function VerificarDND {
    $configContent = Get-Content $configFile
    foreach ($line in $configContent) {
        if ($line -match "DND=(\d)") {
            return $matches[1]
        }
    }
    return 0
}

# Função para atualizar o status do DND e os atalhos
function AtualizarDND {
    param (
        [int]$novoStatus
    )
    $configContent = Get-Content $configFile
    $configContent = $configContent -replace "DND=\d", "DND=$novoStatus"
    if ($novoStatus -eq 1) {
        $configContent = $configContent -replace "0=Ativo;.*;call;.*;1", "0=Ativo;*4801;call;*4802;1"
    } else {
        $configContent = $configContent -replace "0=Ativo;.*;call;.*;1", "0=Inativo;*4801;call;*4800;0"
    }
    Set-Content -Path $configFile -Value $configContent
}

# Variável para armazenar o status anterior do DND
$prevDNDStatus = VerificarDND

# Loop para monitorar o status do DND
while ($true) {
    $dndStatus = VerificarDND
    if ($dndStatus -eq 1 -and $prevDNDStatus -ne 1) {
        # DND foi ativado
        Start-Process -FilePath $microSIPPath -ArgumentList "*4801"
        # Atualize o status do DND e os atalhos
        AtualizarDND -novoStatus 1
    } elseif ($dndStatus -eq 0 -and $prevDNDStatus -eq 1) {
        # DND foi desativado
        Start-Process -FilePath $microSIPPath -ArgumentList "*4800"
        # Atualize o status do DND e os atalhos
        AtualizarDND -novoStatus 0
    }

    # Atualize o status anterior do DND
    $prevDNDStatus = $dndStatus

    # Espera 5 segundos antes de verificar novamente
    Start-Sleep -Seconds 5
}
