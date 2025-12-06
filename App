import React, { useState, useEffect } from 'react';
import { Eye, EyeOff, User, Users, RefreshCw, AlertTriangle, CheckCircle2 } from 'lucide-react';

// Listă de cuvinte extinsă pentru joc
const WORD_LIST = [
  // Animale
  "Câine", "Pisică", "Elefant", "Girafă", "Leu", "Tigru", "Urs", "Lup", "Vulpe", "Iepure",
  "Șoarece", "Hamster", "Papagal", "Vultur", "Bufniță", "Pinguin", "Focă", "Delfin", "Rechin", "Balenă",
  "Caracatiță", "Cal", "Vacă", "Porc", "Oaie", "Capră", "Maimuță", "Gorilă", "Cangur", "Koala",
  "Panda", "Zebra", "Crocodil", "Șarpe", "Broască", "Melc", "Fluture", "Albină", "Furnică", "Păianjen",
  "Scorpion", "Dinozaur", "Dragon", "Unicorn", "Rinocer", "Hipopotam", "Cămilă", "Lama", "Arici", "Veveriță",
  
  // Mâncare & Băutură
  "Pizza", "Burger", "Paste", "Sushi", "Salată", "Supă", "Ciorbă", "Friptură", "Cartofi", "Orez",
  "Pâine", "Sandwich", "Shaorma", "Kebab", "Taco", "Clătite", "Gogoașă", "Înghețată", "Ciocolată", "Tort",
  "Prăjitură", "Plăcintă", "Biscuiți", "Popcorn", "Chipsuri", "Măr", "Banană", "Portocală", "Struguri", "Pepene",
  "Căpșuni", "Cireșe", "Ananas", "Mango", "Avocado", "Roșie", "Castravete", "Morcov", "Ceapă", "Usturoi",
  "Brânză", "Lapte", "Ou", "Iaurt", "Unt", "Cafea", "Ceai", "Suc", "Apă", "Limonadă",
  
  // Obiecte din Casă
  "Masă", "Scaun", "Canapea", "Pat", "Dulap", "Lampă", "Covor", "Perdea", "Oglindă", "Ceas",
  "Televizor", "Telecomandă", "Telefon", "Laptop", "Tabletă", "Căști", "Încărcător", "Frigider", "Aragaz", "Cuptor",
  "Microunde", "Mașină de spălat", "Fier de călcat", "Aspirator", "Mătură", "Găleată", "Farfurie", "Pahar", "Cană", "Furculiță",
  "Lingură", "Cuțit", "Tigaie", "Oală", "Prosop", "Săpun", "Șampon", "Periuță", "Pastă de dinți", "Pieptăn",
  "Pernă", "Pătură", "Cheie", "Portofel", "Geantă", "Rucsac", "Umbrelă", "Ochelari", "Parfum", "Lumânare",

  // Locuri & Clădiri
  "Casă", "Bloc", "Apartament", "Castel", "Palat", "Hotel", "Restaurant", "Cafenea", "Magazin", "Mall",
  "Supermarket", "Piață", "Bancă", "Poștă", "Spital", "Farmacie", "Școală", "Grădiniță", "Liceu", "Facultate",
  "Bibliotecă", "Muzeu", "Teatru", "Cinema", "Stadion", "Sală", "Parc", "Grădină", "Zoo", "Circ",
  "Biserică", "Mănăstire", "Aeroport", "Gară", "Autogară", "Port", "Plajă", "Munte", "Pădure", "Deșert",
  "Junglă", "Insulă", "Peșteră", "Vulcan", "Lac", "Râu", "Mare", "Ocean", "Piscină", "Cimitir",

  // Transport
  "Mașină", "Autobuz", "Tramvai", "Troleibuz", "Metrou", "Tren", "Avion", "Elicopter", "Bicicletă", "Trotinetă",
  "Motocicletă", "Scuter", "Camion", "Tir", "Tractor", "Barcă", "Vapor", "Submarin", "Rachetă", "OZN",
  "Ambulanță", "Pompieri", "Poliție", "Taxi", "Skateboard", "Role", "Sanie", "Căruță", "Balon", "Telecabină",

  // Profesii & Oameni
  "Medic", "Asistent", "Profesor", "Elev", "Student", "Polițist", "Pompier", "Soldat", "Pilot", "Șofer",
  "Bucătar", "Ospătar", "Vânzător", "Casier", "Mecanic", "Electrician", "Instalator", "Zidar", "Zugrav", "Tâmplar",
  "Frizer", "Artist", "Pictor", "Cântăreț", "Actor", "Dansator", "Sportiv", "Fotbalist", "Antrenor", "Arbitru",
  "Avocat", "Judecător", "Preot", "Primar", "Președinte", "Rege", "Regină", "Prinț", "Prințesă", "Cavaler",
  "Pirat", "Ninja", "Samurai", "Viking", "Cowboy", "Astronaut", "Extraterestru", "Robot", "Fantomas", "Vampir",

  // Natură & Diverse
  "Soare", "Lună", "Stea", "Nor", "Ploaie", "Zăpadă", "Fulger", "Tunet", "Curcubeu", "Vânt",
  "Foc", "Apă", "Pământ", "Aer", "Gheață", "Nisip", "Piatră", "Stâncă", "Iarbă", "Floare",
  "Copac", "Frunză", "Creangă", "Rădăcină", "Trandafir", "Lalea", "Ghiocel", "Brad", "Aur", "Argint",
  "Diamant", "Bani", "Card", "Bilet", "Pașaport", "Buletin", "Diplomă", "Cadou", "Cutie", "Sticlă",
  "Minge", "Rachetă", "Chitară", "Pian", "Vioară", "Tobă", "Microfon", "Boxă", "Cameră", "Poză"
];

// Configurația jocului
const TOTAL_PLAYERS = 5;

export default function App() {
  const [gameState, setGameState] = useState('menu'); // menu, playing, finished
  const [currentPlayerIndex, setCurrentPlayerIndex] = useState(0);
  const [isRevealed, setIsRevealed] = useState(false);
  const [currentWord, setCurrentWord] = useState('');
  const [roles, setRoles] = useState([]); // Array de roluri pentru cei 5 jucători

  // Funcție pentru amestecarea unui array (Fisher-Yates shuffle)
  const shuffleArray = (array) => {
    const newArray = [...array];
    for (let i = newArray.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [newArray[i], newArray[j]] = [newArray[j], newArray[i]];
    }
    return newArray;
  };

  // Inițializarea jocului
  const startGame = () => {
    // 1. Alege un cuvânt random
    const randomWord = WORD_LIST[Math.floor(Math.random() * WORD_LIST.length)];
    setCurrentWord(randomWord);

    // 2. Creează lista de roluri (4 cuvinte, 1 impostor)
    const initialRoles = Array(TOTAL_PLAYERS - 1).fill(randomWord);
    initialRoles.push("IMPOSTOR");

    // 3. Amestecă rolurile
    const shuffledRoles = shuffleArray(initialRoles);
    
    setRoles(shuffledRoles);
    setCurrentPlayerIndex(0);
    setIsRevealed(false);
    setGameState('playing');
  };

  // Gestionarea dezvăluirii
  const handleReveal = () => {
    setIsRevealed(true);
  };

  // Gestionarea trecerii la următorul jucător
  const handleNextPlayer = () => {
    if (currentPlayerIndex < TOTAL_PLAYERS - 1) {
      setCurrentPlayerIndex(prev => prev + 1);
      setIsRevealed(false);
    } else {
      setGameState('finished');
    }
  };

  // Resetare la meniu
  const resetGame = () => {
    setGameState('menu');
    setIsRevealed(false);
    setCurrentPlayerIndex(0);
  };

  // --- COMPONENTE UI ---

  // 1. Meniul Principal
  if (gameState === 'menu') {
    return (
      <div className="min-h-screen bg-slate-900 text-white flex flex-col items-center justify-center p-6 text-center font-sans">
        <div className="mb-8 p-4 bg-slate-800 rounded-full shadow-lg shadow-purple-500/20">
          <Users size={64} className="text-purple-400" />
        </div>
        <h1 className="text-5xl font-black mb-2 tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-purple-600">
          IMPOSTORUL
        </h1>
        <p className="text-slate-400 mb-10 text-lg">
          Un joc pentru {TOTAL_PLAYERS} jucători
        </p>
        
        <div className="bg-slate-800 p-6 rounded-xl max-w-sm w-full mb-8 border border-slate-700">
          <h2 className="text-xl font-bold mb-4 text-left border-b border-slate-700 pb-2">Reguli:</h2>
          <ul className="text-left space-y-3 text-slate-300 text-sm">
            <li className="flex items-start gap-2">
              <span className="text-green-400 font-bold">1.</span> 
              <span>Treceți telefonul de la un jucător la altul.</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-green-400 font-bold">2.</span> 
              <span><b className="text-white">4 jucători</b> vor vedea cuvântul secret.</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-red-400 font-bold">3.</span> 
              <span><b className="text-white">1 jucător</b> va vedea "IMPOSTOR".</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-green-400 font-bold">4.</span> 
              <span>Descoperiți cine minte!</span>
            </li>
          </ul>
        </div>

        <button 
          onClick={startGame}
          className="w-full max-w-xs bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-500 hover:to-purple-500 text-white font-bold py-4 px-8 rounded-2xl shadow-xl transition-all transform hover:scale-105 active:scale-95 text-xl flex items-center justify-center gap-3"
        >
          ÎNCEPE JOCUL
        </button>
      </div>
    );
  }

  // 2. Ecranul de Joc (Playing Phase)
  if (gameState === 'playing') {
    const currentRole = roles[currentPlayerIndex];
    const isImpostor = currentRole === "IMPOSTOR";

    return (
      <div className="min-h-screen bg-slate-900 text-white flex flex-col items-center justify-center p-6 relative overflow-hidden">
        {/* Progress Bar */}
        <div className="absolute top-0 left-0 w-full h-2 bg-slate-800">
          <div 
            className="h-full bg-purple-500 transition-all duration-300"
            style={{ width: `${((currentPlayerIndex) / TOTAL_PLAYERS) * 100}%` }}
          ></div>
        </div>

        <div className="w-full max-w-md bg-slate-800/50 backdrop-blur-sm border border-slate-700 rounded-3xl p-8 flex flex-col items-center shadow-2xl min-h-[400px] justify-between">
          
          {/* Header */}
          <div className="text-center">
            <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-slate-700 mb-4 border-2 border-slate-600">
              <User size={32} className="text-slate-300" />
            </div>
            <h2 className="text-2xl font-bold text-slate-300">Jucătorul {currentPlayerIndex + 1}</h2>
            {!isRevealed && (
              <p className="text-slate-500 mt-2 text-sm animate-pulse">
                Asigură-te că nimeni altcineva nu se uită!
              </p>
            )}
          </div>

          {/* Content Area */}
          <div className="flex-1 flex items-center justify-center w-full py-8">
            {!isRevealed ? (
              // Buton REVEAL
              <button 
                onClick={handleReveal}
                className="group relative w-full aspect-video flex flex-col items-center justify-center bg-slate-700 hover:bg-slate-600 rounded-xl border-2 border-dashed border-slate-500 hover:border-purple-400 transition-all cursor-pointer overflow-hidden"
              >
                <Eye size={48} className="text-slate-400 mb-2 group-hover:text-purple-300 transition-colors" />
                <span className="text-xl font-bold text-slate-300 group-hover:text-white">APASĂ PENTRU A VEDEA</span>
                <span className="text-xs text-slate-500 mt-1 uppercase tracking-widest">Secret</span>
              </button>
            ) : (
              // Cuvântul afișat (sau IMPOSTOR)
              <div className="flex flex-col items-center animate-in fade-in zoom-in duration-300">
                <p className="text-sm text-slate-400 uppercase tracking-widest mb-4">Rolul tău este:</p>
                
                {isImpostor ? (
                  <div className="bg-red-900/30 border-2 border-red-500/50 p-8 rounded-2xl w-full text-center shadow-[0_0_30px_rgba(239,68,68,0.2)]">
                    <AlertTriangle size={48} className="mx-auto text-red-500 mb-2" />
                    <h1 className="text-4xl md:text-5xl font-black text-red-500 tracking-wider">
                      IMPOSTOR
                    </h1>
                    <p className="text-red-300 mt-4 text-sm">
                      Încearcă să te integrezi. Nu știi cuvântul secret!
                    </p>
                  </div>
                ) : (
                  <div className="bg-emerald-900/30 border-2 border-emerald-500/50 p-8 rounded-2xl w-full text-center shadow-[0_0_30px_rgba(16,185,129,0.2)]">
                    <CheckCircle2 size={48} className="mx-auto text-emerald-500 mb-2" />
                    <h1 className="text-4xl md:text-5xl font-black text-emerald-400 tracking-wider break-words">
                      {currentRole.toUpperCase()}
                    </h1>
                    <p className="text-emerald-300 mt-4 text-sm">
                      Acesta este cuvântul secret. Găsește impostorul!
                    </p>
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Footer / Next Button */}
          <div className="w-full h-16 flex items-end">
            {isRevealed && (
              <button 
                onClick={handleNextPlayer}
                className="w-full bg-slate-100 hover:bg-white text-slate-900 font-bold py-4 rounded-xl shadow-lg transition-colors flex items-center justify-center gap-2"
              >
                {currentPlayerIndex < TOTAL_PLAYERS - 1 ? "URMĂTORUL JUCĂTOR" : "ÎNCEPE DISCUȚIA"} 
                {currentPlayerIndex < TOTAL_PLAYERS - 1 && <EyeOff size={20} />}
              </button>
            )}
          </div>
        </div>
      </div>
    );
  }

  // 3. Ecran Final (Voting)
  return (
    <div className="min-h-screen bg-slate-900 text-white flex flex-col items-center justify-center p-6 text-center">
      <div className="max-w-md w-full">
        <div className="mb-8 flex justify-center">
          <div className="bg-purple-600 p-4 rounded-full shadow-[0_0_40px_rgba(147,51,234,0.4)] animate-bounce">
            <Users size={48} className="text-white" />
          </div>
        </div>
        
        <h1 className="text-3xl font-bold mb-4">Toate rolurile au fost împărțite!</h1>
        <p className="text-slate-300 mb-12 text-lg leading-relaxed">
          Discutați între voi și votați cine credeți că este <span className="text-red-400 font-bold">IMPOSTORUL</span>.
        </p>

        <div className="bg-slate-800 rounded-xl p-6 border border-slate-700 mb-8 relative overflow-hidden group">
          <div className="absolute inset-0 bg-red-500/10 translate-y-full group-hover:translate-y-0 transition-transform duration-500"></div>
          <p className="text-slate-400 text-sm mb-2 uppercase tracking-widest font-semibold">Când runda s-a terminat</p>
          <p className="text-sm text-slate-500">
            Dacă impostorul este prins, sătenii câștigă. <br/>
            Dacă impostorul supraviețuiește votului, el câștigă!
          </p>
          
          {/* Spoiler Button to show who was the impostor */}
          <details className="mt-6 cursor-pointer">
            <summary className="text-purple-400 hover:text-purple-300 font-bold text-sm select-none list-none bg-slate-900/50 p-3 rounded-lg border border-purple-500/30">
              Apasă aici pentru a vedea răspunsul
            </summary>
            <div className="mt-4 p-4 bg-slate-900 rounded-lg border border-slate-600">
              <p className="text-slate-400 text-sm">Cuvântul a fost:</p>
              <p className="text-2xl font-bold text-emerald-400 mb-2">{currentWord}</p>
              <div className="h-px bg-slate-700 my-2"></div>
              <p className="text-slate-400 text-sm">Impostorul a fost:</p>
              <p className="text-2xl font-bold text-red-500">Jucătorul {roles.indexOf("IMPOSTOR") + 1}</p>
            </div>
          </details>
        </div>

        <button 
          onClick={startGame}
          className="w-full bg-emerald-600 hover:bg-emerald-500 text-white font-bold py-4 px-8 rounded-xl shadow-lg transition-colors flex items-center justify-center gap-2"
        >
          <RefreshCw size={24} />
          JOC NOU
        </button>
        
        <button 
          onClick={resetGame}
          className="mt-4 text-slate-500 hover:text-slate-300 text-sm font-semibold py-2 px-4"
        >
          Înapoi la meniu
        </button>
      </div>
    </div>
  );
}