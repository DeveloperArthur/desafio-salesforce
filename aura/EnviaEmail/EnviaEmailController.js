({
    salvaConta :  function(component, event, helper) {
        let email = component.get("v.email");
        let idDaConta = helper.setIdDaConta(component);
        let nomeDaConta = component.get('v.nomeDaConta');
        let idDopais = component.get('v.idDoPais');
        let podeEnviarEmail = component.find("checkbox").get("v.value");

        let camposValidos = helper.validaCamposObrigatorios(nomeDaConta, idDopais, email);

        if(camposValidos){
            helper.salvaConta(component, idDaConta, nomeDaConta, 
                idDopais, podeEnviarEmail, email);
        }
    }
})