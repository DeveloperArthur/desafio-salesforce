({
    consultaPaises : function(component) {
        const acao = component.get('c.buscaPaises');

        acao.setCallback(this, function(resposta) {
            let jsonResponse = JSON.parse(resposta.getReturnValue());
            this.setPaisesNaTela(component, jsonResponse);
        });
        
        $A.enqueueAction(acao);
    },

    setPaisesNaTela : function(component, paises){
        component.set("v.paises", paises);
    }
})