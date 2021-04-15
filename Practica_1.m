function varargout = Practica_1(varargin)
%PRACTICA_1 MATLAB code file for Practica_1.fig
%      PRACTICA_1, by itself, creates a new PRACTICA_1 or raises the existing
%      singleton*.
%
%      H = PRACTICA_1 returns the handle to a new PRACTICA_1 or the handle to
%      the existing singleton*.
%
%      PRACTICA_1('Property','Value',...) creates a new PRACTICA_1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Practica_1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PRACTICA_1('CALLBACK') and PRACTICA_1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PRACTICA_1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Practica_1

% Last Modified by GUIDE v2.5 07-Apr-2021 13:45:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Practica_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Practica_1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Practica_1 is made visible.
function Practica_1_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes2);
bkg=imread('IPN.png');
imshow(bkg);
axes(handles.axes3);
bkg2=imread('UPIITA.png');
imshow(bkg2);
axes(handles.Axes_Ft);
plot3(1,1,1,'.r')
cla
ax = gca;
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Practica_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Practica_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Practica_1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in B_G.
function B_G_Callback(hObject, eventdata, handles)
I=get(handles.Ft_i,'String');
J=get(handles.Ft_j,'String');
K=get(handles.Ft_k,'String');
d_m=get(handles.d_min,'String');
d_M=get(handles.d_max,'String');
d_i=get(handles.d_inc,'String');

Tg=get(handles.show_v,'Value');
LA=get(handles.show_L,'Value');
Ku=get(handles.show_p_k,'Value');
Ra=get(handles.show_p_r,'Value');
T=get(handles.show_p_T,'Value');

if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
    disp('dominio vacio')
else
    if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
        disp('Funcion vacia')  
    elseif size(I,2)==0 && size(J,2)==0
        disp('Se necesita I y/o J')
    elseif size(K,2)==0 && size(J,2)==0
        disp('Se necesita J y/o K')
    elseif size(I,2)==0 && size(K,2)==0
        disp('Se necesita I y/o K')
    else
        axes(handles.Axes_Ft);
        ax = gca;                
        ax.Color = [0.15 0.15 0.15];
        ax.XColor = [1 0.27 0];
        ax.YColor = [1 0.27 0];
        ax.ZColor = [1 0.27 0];
        cla
                
        Vel = VectorTg(I,J,K);  %Velocidad
        set(handles.v_t,'String',Vel);
        [EcLA,l] = LongA(I,J,K,'','');    %Ecuación Longitud de Arco
        set(handles.l_t,'String',EcLA);
        [Kur,Rad,C,r] = CurV(I,J,K,'','');    %Ecuación Curvatura y radio
        set(handles.k_t,'String',Kur);
        set(handles.r_t,'String',Rad);
        [EcT,EvT] = Torc(I,J,K,'');    %Ecuación Torsión
        set(handles.T_t,'String',EcT);
        
        if count(I,'t')==0 && count(J,'t')==0 && count(K,'t')==0
            [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);
            plot3(Fi,Fj,Fk,'r.','MarkerSize',30);
        else
            [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva 
            plot3(Fi,Fj,Fk,'r','LineWidth',2)  
        end              
        
        hold on
        grid on
        
        %Vector tangente
        if Tg == 1  
            P=get(handles.val_t_v,'String'); %Punto tangente            
            if size(P,2)==0
                disp('Coloque un valor para t')
            else                
                [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
                set(handles.eval_v,'String',VTG)
                plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
                plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
            end
        end
        
        %Longitud de Arco
        if LA == 1
            a=get(handles.lim_max_l,'String'); %Limite superior
            b=get(handles.lim_min_l,'String'); %Limite inferior
            if size(a,2)==0 || size(b,2)==0
                disp('Coloque los limites para la longitud de arco')
            else
                [E,EvL] = LongA(I,J,K,a,b);
                set(handles.eval_l,'String',EvL)
                [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
                plot3(FLi,FLj,FLk,'k','LineWidth',5)
            end
        end
        
        %Curvatura
        if Ku == 1
            pk=get(handles.val_t_k,'String'); %Punto de Curvatura
            if size(pk,2)==0
                disp('Coloque el valor del punto a evaluar')
            else
                [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
                set(handles.eval_k,'String',Evk)
                [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
                plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
            end
        end
        
        %Radio
        if Ra == 1
            pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
            if size(pr,2)==0
                disp('Coloque el valor del punto a evaluar')
            else
                [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
                set(handles.eval_r,'String',Evr)
                [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
                plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
            end
        end
        
        %Torsión
        if T == 1
            pT=get(handles.val_t_T,'String'); %Punto de Torsión
            if size(pT,2)==0
                disp('Coloque el valor del punto a evaluar')
            else
                [EcT,EvT] = Torc(I,J,K,pT);
                set(handles.eval_T,'String',EvT)
                [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
                plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
            end
        end
        
    end

end

% --- Executes on key press with focus on B_G and none of its controls.
function B_G_KeyPressFcn(hObject, eventdata, handles)


% --- Executes on button press in B_L.
function B_L_Callback(hObject, eventdata, handles)
axes(handles.Axes_Ft);
cla
set(handles.Ft_i,'String','');
set(handles.Ft_j,'String','');
set(handles.Ft_k,'String','');
set(handles.d_min,'String','');
set(handles.d_max,'String','');
set(handles.d_inc,'String','');

set(handles.show_v,'Value',0);
set(handles.show_L,'Value',0);
set(handles.show_p_k,'Value',0);
set(handles.show_p_r,'Value',0);
set(handles.show_p_T,'Value',0);

set(handles.v_t,'String','');
set(handles.l_t,'String','');
set(handles.k_t,'String','');
set(handles.r_t,'String','');
set(handles.T_t,'String','');

set(handles.eval_v,'String','');
set(handles.eval_l,'String','');
set(handles.eval_k,'String','');
set(handles.eval_r,'String','');
set(handles.eval_T,'String','');

set(handles.val_t_v,'String','');
set(handles.val_t_k,'String','');
set(handles.val_t_r,'String','');
set(handles.val_t_T,'String','');
set(handles.lim_min_l,'String','');
set(handles.lim_max_l,'String','');



function d_min_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function d_min_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function d_max_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function d_max_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_inc_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function d_inc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_v.
function show_v_Callback(hObject, eventdata, handles)
% I=get(handles.Ft_i,'String');
% J=get(handles.Ft_j,'String');
% K=get(handles.Ft_k,'String');
% d_m=get(handles.d_min,'String');
% d_M=get(handles.d_max,'String');
% d_i=get(handles.d_inc,'String');
% 
% Tg=get(handles.show_v,'Value');
% LA=get(handles.show_L,'Value');
% Ku=get(handles.show_p_k,'Value');
% Ra=get(handles.show_p_r,'Value');
% T=get(handles.show_p_T,'Value');
% 
% if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
%     disp('dominio vacio')
% else
%     if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
%         disp('Funcion vacia')  
%     elseif size(I,2)==0 && size(J,2)==0
%         disp('Se necesita I y/o J')
%     elseif size(K,2)==0 && size(J,2)==0
%         disp('Se necesita J y/o K')
%     elseif size(I,2)==0 && size(K,2)==0
%         disp('Se necesita I y/o K')
%     else
%         axes(handles.Axes_Ft);
%         ax = gca;
%         ax.Color = [0.15 0.15 0.15];
%         ax.XColor = [1 0.27 0];
%         ax.YColor = [1 0.27 0];
%         ax.ZColor = [1 0.27 0];
%         cla
%         
%         Vel = VectorTg(I,J,K);  %Velocidad
%         set(handles.v_t,'String',Vel);
%         [EcLA,l] = LongA(I,J,K,'n','n');    %Ecuación Longitud de Arco
%         set(handles.l_t,'String',EcLA);
%         [Kur,Rad,C,r] = CurV(I,J,K,'n','n');    %Ecuación Curvatura y radio
%         set(handles.k_t,'String',Kur);
%         set(handles.r_t,'String',Rad);
%         [EcT,EvT] = Torc(I,J,K,'n');    %Ecuación Torsión
%         set(handles.T_t,'String',EcT);
%         
%         [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva               
%               
%         plot3(Fi,Fj,Fk,'r','LineWidth',2)
%         hold on
%         grid on
%         
%         %Vector tangente
%         if Tg == 1  
%             P=get(handles.val_t_v,'String'); %Punto tangente            
%             if size(P,2)==0
%                 disp('Coloque un valor para t')
%             else                
%                 [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
%                 set(handles.eval_v,'String',VTG)
%                 plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
%                 plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
%             end
%         end
%         
%         %Longitud de Arco
%         if LA == 1
%             a=get(handles.lim_max_l,'String'); %Limite superior
%             b=get(handles.lim_min_l,'String'); %Limite inferior
%             if size(a,2)==0 || size(b,2)==0
%                 disp('Coloque los limites para la longitud de arco')
%             else
%                 [E,EvL] = LongA(I,J,K,a,b);
%                 set(handles.eval_l,'String',EvL)
%                 [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
%                 plot3(FLi,FLj,FLk,'k','LineWidth',5)
%             end
%         end
%         
%         %Curvatura
%         if Ku == 1
%             pk=get(handles.val_t_k,'String'); %Punto de Curvatura
%             if size(pk,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
%                 set(handles.eval_k,'String',Evk)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
%                 plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
%             end
%         end
%         
%         %Radio
%         if Ra == 1
%             pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
%             if size(pr,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
%                 set(handles.eval_r,'String',Evr)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
%             end
%         end
%         
%         %Torsión
%         if T == 1
%             pT=get(handles.val_t_T,'String'); %Punto de Torsión
%             if size(pT,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [EcT,EvT] = Torc(I,J,K,pT);
%                 set(handles.eval_T,'String',EvT)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
%             end
%         end
%         
%     end
% 
% end



function val_t_v_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function val_t_v_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_t_T_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function val_t_T_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_p_T.
function show_p_T_Callback(hObject, eventdata, handles)
% I=get(handles.Ft_i,'String');
% J=get(handles.Ft_j,'String');
% K=get(handles.Ft_k,'String');
% d_m=get(handles.d_min,'String');
% d_M=get(handles.d_max,'String');
% d_i=get(handles.d_inc,'String');
% 
% Tg=get(handles.show_v,'Value');
% LA=get(handles.show_L,'Value');
% Ku=get(handles.show_p_k,'Value');
% Ra=get(handles.show_p_r,'Value');
% T=get(handles.show_p_T,'Value');
% 
% if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
%     disp('dominio vacio')
% else
%     if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
%         disp('Funcion vacia')  
%     elseif size(I,2)==0 && size(J,2)==0
%         disp('Se necesita I y/o J')
%     elseif size(K,2)==0 && size(J,2)==0
%         disp('Se necesita J y/o K')
%     elseif size(I,2)==0 && size(K,2)==0
%         disp('Se necesita I y/o K')
%     else
%         axes(handles.Axes_Ft);
%         ax = gca;
%         ax.Color = [0.15 0.15 0.15];
%         ax.XColor = [1 0.27 0];
%         ax.YColor = [1 0.27 0];
%         ax.ZColor = [1 0.27 0];
%         cla
%         
%         Vel = VectorTg(I,J,K);  %Velocidad
%         set(handles.v_t,'String',Vel);
%         [EcLA,l] = LongA(I,J,K,'n','n');    %Ecuación Longitud de Arco
%         set(handles.l_t,'String',EcLA);
%         [Kur,Rad,C,r] = CurV(I,J,K,'n','n');    %Ecuación Curvatura y radio
%         set(handles.k_t,'String',Kur);
%         set(handles.r_t,'String',Rad);
%         [EcT,EvT] = Torc(I,J,K,'n');    %Ecuación Torsión
%         set(handles.T_t,'String',EcT);
%         
%         [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva               
%               
%         plot3(Fi,Fj,Fk,'r','LineWidth',2)
%         hold on
%         grid on
%         
%         %Vector tangente
%         if Tg == 1  
%             P=get(handles.val_t_v,'String'); %Punto tangente            
%             if size(P,2)==0
%                 disp('Coloque un valor para t')
%             else                
%                 [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
%                 set(handles.eval_v,'String',VTG)
%                 plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
%                 plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
%             end
%         end
%         
%         %Longitud de Arco
%         if LA == 1
%             a=get(handles.lim_max_l,'String'); %Limite superior
%             b=get(handles.lim_min_l,'String'); %Limite inferior
%             if size(a,2)==0 || size(b,2)==0
%                 disp('Coloque los limites para la longitud de arco')
%             else
%                 [E,EvL] = LongA(I,J,K,a,b);
%                 set(handles.eval_l,'String',EvL)
%                 [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
%                 plot3(FLi,FLj,FLk,'k','LineWidth',5)
%             end
%         end
%         
%         %Curvatura
%         if Ku == 1
%             pk=get(handles.val_t_k,'String'); %Punto de Curvatura
%             if size(pk,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
%                 set(handles.eval_k,'String',Evk)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
%                 plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
%             end
%         end
%         
%         %Radio
%         if Ra == 1
%             pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
%             if size(pr,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
%                 set(handles.eval_r,'String',Evr)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
%             end
%         end
%         
%         %Torsión
%         if T == 1
%             pT=get(handles.val_t_T,'String'); %Punto de Torsión
%             if size(pT,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [EcT,EvT] = Torc(I,J,K,pT);
%                 set(handles.eval_T,'String',EvT)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
%             end
%         end
%         
%     end
% 
% end



function val_t_k_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function val_t_k_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_p_k.
function show_p_k_Callback(hObject, eventdata, handles)
% I=get(handles.Ft_i,'String');
% J=get(handles.Ft_j,'String');
% K=get(handles.Ft_k,'String');
% d_m=get(handles.d_min,'String');
% d_M=get(handles.d_max,'String');
% d_i=get(handles.d_inc,'String');
% 
% Tg=get(handles.show_v,'Value');
% LA=get(handles.show_L,'Value');
% Ku=get(handles.show_p_k,'Value');
% Ra=get(handles.show_p_r,'Value');
% T=get(handles.show_p_T,'Value');
% 
% if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
%     disp('dominio vacio')
% else
%     if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
%         disp('Funcion vacia')  
%     elseif size(I,2)==0 && size(J,2)==0
%         disp('Se necesita I y/o J')
%     elseif size(K,2)==0 && size(J,2)==0
%         disp('Se necesita J y/o K')
%     elseif size(I,2)==0 && size(K,2)==0
%         disp('Se necesita I y/o K')
%     else
%         axes(handles.Axes_Ft);
%         ax = gca;
%         ax.Color = [0.15 0.15 0.15];
%         ax.XColor = [1 0.27 0];
%         ax.YColor = [1 0.27 0];
%         ax.ZColor = [1 0.27 0];
%         cla
%         
%         Vel = VectorTg(I,J,K);  %Velocidad
%         set(handles.v_t,'String',Vel);
%         [EcLA,l] = LongA(I,J,K,'n','n');    %Ecuación Longitud de Arco
%         set(handles.l_t,'String',EcLA);
%         [Kur,Rad,C,r] = CurV(I,J,K,'n','n');    %Ecuación Curvatura y radio
%         set(handles.k_t,'String',Kur);
%         set(handles.r_t,'String',Rad);
%         [EcT,EvT] = Torc(I,J,K,'n');    %Ecuación Torsión
%         set(handles.T_t,'String',EcT);
%         
%         [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva               
%               
%         plot3(Fi,Fj,Fk,'r','LineWidth',2)
%         hold on
%         grid on
%         
%         %Vector tangente
%         if Tg == 1  
%             P=get(handles.val_t_v,'String'); %Punto tangente            
%             if size(P,2)==0
%                 disp('Coloque un valor para t')
%             else                
%                 [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
%                 set(handles.eval_v,'String',VTG)
%                 plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
%                 plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
%             end
%         end
%         
%         %Longitud de Arco
%         if LA == 1
%             a=get(handles.lim_max_l,'String'); %Limite superior
%             b=get(handles.lim_min_l,'String'); %Limite inferior
%             if size(a,2)==0 || size(b,2)==0
%                 disp('Coloque los limites para la longitud de arco')
%             else
%                 [E,EvL] = LongA(I,J,K,a,b);
%                 set(handles.eval_l,'String',EvL)
%                 [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
%                 plot3(FLi,FLj,FLk,'k','LineWidth',5)
%             end
%         end
%         
%         %Curvatura
%         if Ku == 1
%             pk=get(handles.val_t_k,'String'); %Punto de Curvatura
%             if size(pk,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
%                 set(handles.eval_k,'String',Evk)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
%                 plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
%             end
%         end
%         
%         %Radio
%         if Ra == 1
%             pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
%             if size(pr,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
%                 set(handles.eval_r,'String',Evr)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
%             end
%         end
%         
%         %Torsión
%         if T == 1
%             pT=get(handles.val_t_T,'String'); %Punto de Torsión
%             if size(pT,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [EcT,EvT] = Torc(I,J,K,pT);
%                 set(handles.eval_T,'String',EvT)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
%             end
%         end
%         
%     end
% 
% end


function Ft_i_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Ft_i_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ft_j_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Ft_j_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Ft_k_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Ft_k_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function lim_min_l_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function lim_min_l_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lim_max_l_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function lim_max_l_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_L.
function show_L_Callback(hObject, eventdata, handles)
% I=get(handles.Ft_i,'String');
% J=get(handles.Ft_j,'String');
% K=get(handles.Ft_k,'String');
% d_m=get(handles.d_min,'String');
% d_M=get(handles.d_max,'String');
% d_i=get(handles.d_inc,'String');
% 
% Tg=get(handles.show_v,'Value');
% LA=get(handles.show_L,'Value');
% Ku=get(handles.show_p_k,'Value');
% Ra=get(handles.show_p_r,'Value');
% T=get(handles.show_p_T,'Value');
% 
% if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
%     disp('dominio vacio')
% else
%     if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
%         disp('Funcion vacia')  
%     elseif size(I,2)==0 && size(J,2)==0
%         disp('Se necesita I y/o J')
%     elseif size(K,2)==0 && size(J,2)==0
%         disp('Se necesita J y/o K')
%     elseif size(I,2)==0 && size(K,2)==0
%         disp('Se necesita I y/o K')
%     else
%         axes(handles.Axes_Ft);
%         ax = gca;
%         ax.Color = [0.15 0.15 0.15];
%         ax.XColor = [1 0.27 0];
%         ax.YColor = [1 0.27 0];
%         ax.ZColor = [1 0.27 0];
%         cla
%         
%         Vel = VectorTg(I,J,K);  %Velocidad
%         set(handles.v_t,'String',Vel);
%         [EcLA,l] = LongA(I,J,K,'n','n');    %Ecuación Longitud de Arco
%         set(handles.l_t,'String',EcLA);
%         [Kur,Rad,C,r] = CurV(I,J,K,'n','n');    %Ecuación Curvatura y radio
%         set(handles.k_t,'String',Kur);
%         set(handles.r_t,'String',Rad);
%         [EcT,EvT] = Torc(I,J,K,'n');    %Ecuación Torsión
%         set(handles.T_t,'String',EcT);
%         
%         [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva               
%               
%         plot3(Fi,Fj,Fk,'r','LineWidth',2)
%         hold on
%         grid on
%         
%         %Vector tangente
%         if Tg == 1  
%             P=get(handles.val_t_v,'String'); %Punto tangente            
%             if size(P,2)==0
%                 disp('Coloque un valor para t')
%             else                
%                 [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
%                 set(handles.eval_v,'String',VTG)
%                 plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
%                 plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
%             end
%         end
%         
%         %Longitud de Arco
%         if LA == 1
%             a=get(handles.lim_max_l,'String'); %Limite superior
%             b=get(handles.lim_min_l,'String'); %Limite inferior
%             if size(a,2)==0 || size(b,2)==0
%                 disp('Coloque los limites para la longitud de arco')
%             else
%                 [E,EvL] = LongA(I,J,K,a,b);
%                 set(handles.eval_l,'String',EvL)
%                 [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
%                 plot3(FLi,FLj,FLk,'k','LineWidth',5)
%             end
%         end
%         
%         %Curvatura
%         if Ku == 1
%             pk=get(handles.val_t_k,'String'); %Punto de Curvatura
%             if size(pk,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
%                 set(handles.eval_k,'String',Evk)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
%                 plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
%             end
%         end
%         
%         %Radio
%         if Ra == 1
%             pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
%             if size(pr,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
%                 set(handles.eval_r,'String',Evr)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
%             end
%         end
%         
%         %Torsión
%         if T == 1
%             pT=get(handles.val_t_T,'String'); %Punto de Torsión
%             if size(pT,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [EcT,EvT] = Torc(I,J,K,pT);
%                 set(handles.eval_T,'String',EvT)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
%             end
%         end
%         
%     end
% 
% end


function val_t_r_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function val_t_r_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_p_r.
function show_p_r_Callback(hObject, eventdata, handles)
% I=get(handles.Ft_i,'String');
% J=get(handles.Ft_j,'String');
% K=get(handles.Ft_k,'String');
% d_m=get(handles.d_min,'String');
% d_M=get(handles.d_max,'String');
% d_i=get(handles.d_inc,'String');
% 
% Tg=get(handles.show_v,'Value');
% LA=get(handles.show_L,'Value');
% Ku=get(handles.show_p_k,'Value');
% Ra=get(handles.show_p_r,'Value');
% T=get(handles.show_p_T,'Value');
% 
% if size(d_m,2)==0 || size(d_M,2)==0 || size(d_i,2)==0
%     disp('dominio vacio')
% else
%     if size(I,2)==0 && size(J,2)==0 && size(K,2)==0
%         disp('Funcion vacia')  
%     elseif size(I,2)==0 && size(J,2)==0
%         disp('Se necesita I y/o J')
%     elseif size(K,2)==0 && size(J,2)==0
%         disp('Se necesita J y/o K')
%     elseif size(I,2)==0 && size(K,2)==0
%         disp('Se necesita I y/o K')
%     else
%         axes(handles.Axes_Ft);
%         ax = gca;
%         ax.Color = [0.15 0.15 0.15];
%         ax.XColor = [1 0.27 0];
%         ax.YColor = [1 0.27 0];
%         ax.ZColor = [1 0.27 0];
%         cla
%         
%         Vel = VectorTg(I,J,K);  %Velocidad
%         set(handles.v_t,'String',Vel);
%         [EcLA,l] = LongA(I,J,K,'n','n');    %Ecuación Longitud de Arco
%         set(handles.l_t,'String',EcLA);
%         [Kur,Rad,C,r] = CurV(I,J,K,'n','n');    %Ecuación Curvatura y radio
%         set(handles.k_t,'String',Kur);
%         set(handles.r_t,'String',Rad);
%         [EcT,EvT] = Torc(I,J,K,'n');    %Ecuación Torsión
%         set(handles.T_t,'String',EcT);
%         
%         [Fi,Fj,Fk]=Curva(I,J,K,d_m,d_M,d_i);    %Gráfica de la curva               
%               
%         plot3(Fi,Fj,Fk,'r','LineWidth',2)
%         hold on
%         grid on
%         
%         %Vector tangente
%         if Tg == 1  
%             P=get(handles.val_t_v,'String'); %Punto tangente            
%             if size(P,2)==0
%                 disp('Coloque un valor para t')
%             else                
%                 [Fpi,Fpj,Fpk,RT_I,RT_J,RT_K,VTG]=RectaTg(I,J,K,P);
%                 set(handles.eval_v,'String',VTG)
%                 plot3(RT_I,RT_J,RT_K,'w--','LineWidth',2)
%                 plot3(Fpi,Fpj,Fpk,'.b','MarkerSize',25)
%             end
%         end
%         
%         %Longitud de Arco
%         if LA == 1
%             a=get(handles.lim_max_l,'String'); %Limite superior
%             b=get(handles.lim_min_l,'String'); %Limite inferior
%             if size(a,2)==0 || size(b,2)==0
%                 disp('Coloque los limites para la longitud de arco')
%             else
%                 [E,EvL] = LongA(I,J,K,a,b);
%                 set(handles.eval_l,'String',EvL)
%                 [FLi,FLj,FLk]=Curva(I,J,K,b,a,d_i);    %Gráfica de LA 
%                 plot3(FLi,FLj,FLk,'k','LineWidth',5)
%             end
%         end
%         
%         %Curvatura
%         if Ku == 1
%             pk=get(handles.val_t_k,'String'); %Punto de Curvatura
%             if size(pk,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,pk,'n');
%                 set(handles.eval_k,'String',Evk)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pk,pk,d_i);    %Gráfica punto K 
%                 plot3(FLi,FLj,FLk,'.m','MarkerSize',25)
%             end
%         end
%         
%         %Radio
%         if Ra == 1
%             pr=get(handles.val_t_r,'String'); %Punto de Radio de Curvatura
%             if size(pr,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [C,r,Evk,Evr] = CurV(I,J,K,'n',pr);
%                 set(handles.eval_r,'String',Evr)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pr,pr,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.y','MarkerSize',25)
%             end
%         end
%         
%         %Torsión
%         if T == 1
%             pT=get(handles.val_t_T,'String'); %Punto de Torsión
%             if size(pT,2)==0
%                 disp('Coloque el valor del punto a evaluar')
%             else
%                 [EcT,EvT] = Torc(I,J,K,pT);
%                 set(handles.eval_T,'String',EvT)
%                 [FLi,FLj,FLk]=Curva(I,J,K,pT,pT,d_i);    %Gráfica punto R 
%                 plot3(FLi,FLj,FLk,'.c','MarkerSize',25)
%             end
%         end
%         
%     end
% 
% end
