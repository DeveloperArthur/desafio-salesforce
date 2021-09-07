({
    setIdDaConta : function(component){
        let idDaConta = component.get('v.idDaConta');
        if(idDaConta == '') return null;
        return idDaConta;
    },

    validaCamposObrigatorios : function(nomeDaConta, idDopais, email){
        if(
            nomeDaConta == '' || nomeDaConta == undefined || 
            idDopais == '' || idDopais == undefined || 
            email == '' || email == undefined
        ){
            this.mostraMensagem("warning","Os campos obrigatórios (Nome, País e Email) devem ser preenchidos");
            return false;
        }
        return true;
    },

    salvaConta : function(component, idDaConta, nomeDaConta, 
        idDopais, podeEnviarEmail, email){
        
        component.find("spinner").mostraCarregamento();

        const acao = component.get('c.upsertConta');
        
        acao.setParams({ 
            id: idDaConta, 
            nome: nomeDaConta,
            idPais: idDopais,
            podeEnviarEmail: podeEnviarEmail,
            email: email
        });

        acao.setCallback(this, function(resposta) {
            let jsonResponse = JSON.parse(resposta.getReturnValue());
            this.validaOperacao(jsonResponse);

            component.find("spinner").escondeCarregamento();
        });
        
        $A.enqueueAction(acao);
    },

    validaOperacao : function(jsonResponse){
        if(jsonResponse != null) 
            this.mostraMensagem("success","Salvo com sucesso!");
        else 
            this.mostraMensagem("error", "Ocorreu um erro, verifique se o id informado está correto");
    },

    mostraMensagem : function(tipo, mensagem) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": tipo,
            "message": mensagem
        });
        toastEvent.fire();
    }
})