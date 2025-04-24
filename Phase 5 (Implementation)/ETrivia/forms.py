from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import get_user_model

class SignupForm(UserCreationForm):
    # Autor : Filip Rinkovec 0463/2019
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs)
        self.fields['username'].widget.attrs.update({
            'class':'form-input'
        })

    username = forms.CharField(max_length=150)
    password1 = forms.CharField(widget=forms.PasswordInput, label="Password")
    password2 = forms.CharField(widget=forms.PasswordInput, label="Password Confirmation")
    class Meta:
        model = get_user_model()
        fields = ['username', 'password1', 'password2']